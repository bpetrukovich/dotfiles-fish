if not status is-interactive
    exit
end


function my_hook_start --on-event fish_preexec
    set -g cmd_start_time (date +%s.%N)
    set -g current_command $argv
end

function my_hook_end --on-event fish_postexec
    set cmd_end_time (date +%s.%N)
    set duration (math "$cmd_end_time - $cmd_start_time")

    if test $duration -ge 10
        if test $status -eq 0
            set title "Done"
        else
            set title "Error $status"
        end
        
        function escape_xml
            set text $argv[1]
            string replace '&' '&amp;' $text | string replace '<' '&lt;' | string replace '>' '&gt;' | string replace '"' '&quot;' | string replace "'" '&apos;'
        end

        set ps_title (escape_xml "$title ($duration s)")
        set ps_message (escape_xml "$current_command")

        powershell.exe -NoProfile -Command "
            [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType=WindowsRuntime] | Out-Null;
            [Windows.UI.Notifications.ToastNotification, Windows.UI.Notifications, ContentType=WindowsRuntime] | Out-Null;
            \$xml = New-Object Windows.Data.Xml.Dom.XmlDocument;
            \$xml.LoadXml('<toast><visual><binding template=\"ToastText02\"><text id=\"1\">$ps_title</text><text id=\"2\">$ps_message</text></binding></visual></toast>');
            \$toast = [Windows.UI.Notifications.ToastNotification]::new(\$xml);
            [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier('WSL').Show(\$toast);
        "
    end
    
    set -e cmd_start_time
    set -e current_command
end

function done
    set start_time (date +%s.%N)
    
    $argv
    set exit_code $status
    set end_time (date +%s.%N)
    
    set cmd (string join " " $argv)
    set duration (math "$end_time - $start_time")

    if test $exit_code -eq 0
        set title "Done"
    else
        set title "Error $exit_code"
    end

    function escape_xml
        set text $argv[1]
        string replace '&' '&amp;' $text | string replace '<' '&lt;' | string replace '>' '&gt;' | string replace '"' '&quot;' | string replace "'" '&apos;'
    end

    set ps_title (escape_xml "$title ($duration s)")
    set ps_message (escape_xml $cmd)

    powershell.exe -NoProfile -Command "
        [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType=WindowsRuntime] | Out-Null;
        [Windows.UI.Notifications.ToastNotification, Windows.UI.Notifications, ContentType=WindowsRuntime] | Out-Null;
        \$xml = New-Object Windows.Data.Xml.Dom.XmlDocument;
        \$xml.LoadXml('<toast><visual><binding template=\"ToastText02\"><text id=\"1\">$ps_title</text><text id=\"2\">$ps_message</text></binding></visual></toast>');
        \$toast = [Windows.UI.Notifications.ToastNotification]::new(\$xml);
        [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier('WSL').Show(\$toast);
    "
end
