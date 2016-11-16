from i3pystatus import Status

status = Status(standalone=True)

# First separator
status.register("text",
    text="",)

# Volume
status.register("pulseaudio",
    format="🔊  {volume}",
    format_muted="🔇  {volume}",
    color_muted="#FFD801",
    on_leftclick="zsh /home/plastic/.config/i3pystatus/pulseaudio.sh",
    hints={
        "separator_block_width": 42,
    },)

# Battery
status.register("battery",
    format="{status} {percentage_design:.0f}%{remaining:%E⁣   %hh%Mm}",
    alert=True,
    alert_percentage=10,
    full_color="#3BB9FF",
    color="#FFD801",
    charging_color="#4AA02C",
    critical_color="#C11B17",
    on_leftclick='notify-send -u low "`acpi -iab`"',
    status={
        "DPL": "⚠ ",
       	"DIS": "🔋 ",
       	"CHR": "⚡",
       	"FULL": "🔌 ",
    },
    hints={
        "separator_block_width": 42,
    },)

# RAM usage
status.register("mem_bar",
    format="RAM  {used_mem_bar}",
    color="#4AA02C",
    alert_color="#C11B17",
    multi_colors="true",
    on_leftclick="zsh /home/plastic/.config/i3pystatus/htop.sh",
    hints={
        "separator_block_width": 42,
        "min_width": 81,
    },)

# CPU usage
status.register("cpu_usage_bar",
    format="CPU  {usage_bar}",
    start_color="#4AA02C",
    end_color="#C11B17",
    on_leftclick="zsh /home/plastic/.config/i3pystatus/htop.sh",
    hints={
        "separator_block_width": 42,
        "min_width": 81,
    },)

# Clock
status.register("clock",
    format="🕓 %X",
    on_leftclick=["zsh /home/plastic/.config/i3pystatus/clock.sh"],
    hints={
        "separator_block_width": 42,
    },)

# Date
status.register("clock",
    format="📅 %A %-d %B",
    on_leftclick="zsh /home/plastic/.config/i3pystatus/calendar.sh",
    hints={
        "separator": False,
        "separator_block_width": 28,
    },)

# Music
status.register("now_playing",
    format="{status}  {artist} - {title}",
    status={
        'stop': '◾',
        'play': '▶',
        'pause': '⏸'
    },
    hints={
        "separator_block_width": 42,
    },)

status.run()
