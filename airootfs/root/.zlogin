# Automatické spuštění instalace pro klienty
if [[ -x /root/install.sh ]]; then
    echo "Spouštím automatickou instalaci..."
    /root/install.sh
fi

# fix for screen readers
if grep -Fqa 'accessibility=' /proc/cmdline &> /dev/null; then
    setopt SINGLE_LINE_ZLE
fi

~/.automated_script.sh
