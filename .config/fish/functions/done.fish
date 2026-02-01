function done
    $argv
    set exit_code $status

    set cmd (string join " " $argv)

    if test $exit_code -eq 0
        set title "Done"
    else
        set title "Error ($exit_code)"
    end

    function escape_xml
        set text $argv[1]
        string replace '&' '&amp;' $text | string replace '<' '&lt;' | string replace '>' '&gt;' | string replace '"' '&quot;' | string replace "'" '&apos;'
    end

    set ps_title (escape_xml $title)
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
