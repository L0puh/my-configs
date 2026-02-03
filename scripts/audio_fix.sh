#/bin/bash
systemctl --user restart --now pipewire pipewire-pulse wireplumber
# systemctl --user disable pulseaudio.socket pulseaudio.service 2>/dev/null
# systemctl --user mask pulseaudio.socket pulseaudio.service 2>/dev/null
systemctl --user status pipewire pipewire-pulse

