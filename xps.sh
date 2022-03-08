#!/bin/sh
installaws() {\
    [ -f /tmp/awscliv2.zip ] || sudo -u "$name" curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o /tmp/awscliv2.zip
    [ -d /tmp/aws ] || sudo -u "$name" unzip -q /tmp/awscliv2.zip -d /tmp
    [ -d /usr/local/aws-cli/v2/current ] || sudo -u "$name" sudo /tmp/aws/install
}

installacpiconfig() {\
    # TODO: ensure directories /etc/acpi/events and /etc/acpi/handlers exists first
    [ -f "/etc/acpi/events/vol-d" ] || ln -s /home/"$name"/.config/acpi/events/vol-d /etc/acpi/events/vol-d
    [ -f "/etc/acpi/events/vol-m" ] || ln -s /home/"$name"/.config/acpi/events/vol-m /etc/acpi/events/vol-m
    [ -f "/etc/acpi/events/vol-u" ] || ln -s /home/"$name"/.config/acpi/events/vol-u /etc/acpi/events/vol-u
    [ -f "/etc/acpi/events/brightness_down" ] || ln -s /home/"$name"/.config/acpi/events/brightness_down /etc/acpi/events/brightness_down
    [ -f "/etc/acpi/events/brightness_up" ] || ln -s /home/"$name"/.config/acpi/events/brightness_up /etc/acpi/events/brightness_up
    [ -f "/etc/acpi/handlers/brightness" ] || ln -s /home/"$name"/.config/acpi/handlers/brightness /etc/acpi/handlers/brightness
}

installpoweroptions() {\
    # TODO: only add to file if line doesn't already exist
    echo "HandlePowerKey=suspend" | tee -a /etc/systemd/logind.conf
    echo "HandleLidSwitch=suspend" | tee -a /etc/systemd/logind.conf
    echo "HandleLidSwitchExternalPower=suspend" | tee -a /etc/systemd/logind.conf
}

installaws
installacpiconfig
installpoweroptions
