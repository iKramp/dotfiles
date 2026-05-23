hl.on("hyprland.start", function ()
    hl.exec_cmd("~/.config/waybar/launch.sh")
    hl.exec_cmd("~/dotfiles/scripts/loop_random_wallpapers.sh")
    hl.exec_cmd("swaync")
    hl.exec_cmd("swayosd-server")
    hl.exec_cmd("udiskie")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("wl-paste --type text  --watch cliphist store")
    hl.exec_cmd("fcitx5 -d -r")
    hl.exec_cmd("fcitx5-remote -r")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("wayscriber --daemon --no-tray")
end)

hl.monitor({output = "DP-1", mode = "2560x1440@144", position = "0x0", scale = 1.0, transform = 0})
hl.monitor({output = "DP-3", mode = "1920x1200@60", position = "-1200x-240", scale = 1.0, transform = 3})
hl.monitor({output = "eDP-1", mode = "1920x1080@60", position = "auto", scale = 1.0})

hl.env("HYPRCURSOR_THEME", "NotwaitaBlack")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "NotwaitaBlack")

hl.config({
    input = {
        kb_layout = "us,si",
        kb_options = "grp:caps_toggle",

        follow_mouse = 1,

        sensitivity = 0.0,

        numlock_by_default = true,

        touchpad = {
            natural_scroll = true,
            scroll_factor = 0.5,
            drag_lock = 1
        }
    },
    general = {
        gaps_in = 2,
        gaps_out = 4,
        border_size = 1,
        col = {
            active_border = { colors = { "rgba(33ccffee)", "rgba(33ccffee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        layout = "dwindle",
    },
    dwindle = {
        preserve_split = true
    },
    gestures = {
        workspace_swipe_distance = 1300,
        workspace_swipe_cancel_ratio = 0.2,
        workspace_swipe_min_speed_to_force = 20,
        workspace_swipe_create_new = false
    },
    ecosystem = {
        no_update_news = true,
        no_donation_nag = true,
    },
    decoration = {
        rounding = 6,
        blur = {
            enabled = false,
            passes = 3,
            size = 5,
            contrast = 0.8916,
            brightness = 0.8172,
            vibrancy = 0.1696,
            vibrancy_darkness = 0.0,
            ignore_opacity = true,
        },
        shadow = {
            enabled = true,
            color = "rgba(1a1a1aee)",
            render_power = 3,
            range = 3,
        }
    },
    animations = {
        enabled = true,
        workspace_wraparound = false,
    },
    misc = {
        middle_click_paste = false,
    },
    xwayland = {
        use_nearest_neighbor = true,
    }
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

hl.curve( "my_bezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })

hl.animation({ leaf = "windows", enabled = true, speed = 4, bezier = "my_bezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 4, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 2, bezier = "default", style = "slidevert" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 1, bezier = "my_bezier" })


hl.workspace_rule({workspace = "2", monitor = "DP-3"})
hl.workspace_rule({workspace = "3", monitor = "DP-3"})

hl.workspace_rule({workspace = "1", monitor = "DP-1"})
hl.workspace_rule({workspace = "4", monitor = "DP-1"})
hl.workspace_rule({workspace = "5", monitor = "DP-1"})
hl.workspace_rule({workspace = "6", monitor = "DP-1"})
hl.workspace_rule({workspace = "7", monitor = "DP-1"})
hl.workspace_rule({workspace = "8", monitor = "DP-1"})
hl.workspace_rule({workspace = "9", monitor = "DP-1"})
hl.workspace_rule({workspace = "10", monitor = "DP-1"})


hl.window_rule({ match = { class = "java" }, stay_focused = true })
hl.window_rule({ match = { class = "steam" }, min_size = { 5, 5 } })
hl.window_rule({ match = { title = "Keyboard_visualizer" }, float = true })
hl.window_rule({ match = { title = "Keyboard_visualizer" }, pin = true })
hl.window_rule({ match = { class = "jetbrains-.*", title = "splash", float = true }, center = true, no_initial_focus = true, border_size = 0 })
hl.window_rule({ match = { class = "jetbrains-.*", title = " ", float = true }, center = true, border_size = 0 })
hl.window_rule({ match = { class = "jetbrains-.*", title = "win(.*)", float = true }, no_initial_focus = true })
hl.window_rule({ match = { title = "Konata Dancer" }, no_blur = true, border_size = 0, decorate = false })

-- mainmod is SUPER
-- bind = $mainMod, TAB, focuscurrentorlast

hl.bind("SUPER + TAB", hl.dsp.focus({ last = true }))

hl.bind("SUPER + S", hl.dsp.exec_cmd("hyprctl setprop active opaque toggle"))
hl.bind("SUPER + SHIFT + Q", hl.dsp.window.close())
hl.bind("SUPER + W", hl.dsp.exec_cmd("rofi -show drun -matching prefix -drun-match-fields name -no-tokenize -replace -config ~/.config/rofi/rofi-app.rasi"))
hl.bind("ALT + SPACE", hl.dsp.exec_cmd("rofi -show calc -modi calc -no-show-match -no-sort -config ~/dotfiles/.config/rofi/rofi-app.rasi -calc-command \"echo -n '{result}' | wl-copy\""))
hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("kitty"))
hl.bind("SUPER + CONTROL + T", hl.dsp.exec_cmd("~/dotfiles/.config/waybar/launch.sh"))
hl.bind("PRINT", hl.dsp.exec_cmd("~/dotfiles/scripts/screenshot.sh"))
hl.bind("SUPER + T", hl.dsp.window.float())
hl.bind("SUPER + F", hl.dsp.window.fullscreen())
-- bind = $mainMod, J, togglesplit, # dwindle find a way to do this
hl.bind("SUPER + LEFT", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + RIGHT", hl.dsp.focus({ direction = "r" }))
hl.bind("SUPER + UP", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + DOWN", hl.dsp.focus({ direction = "d" }))

hl.bind("SUPER + 1", hl.dsp.focus({ workspace = "1" }))
hl.bind("SUPER + 2", hl.dsp.focus({ workspace = "2" }))
hl.bind("SUPER + 3", hl.dsp.focus({ workspace = "3" }))
hl.bind("SUPER + 4", hl.dsp.focus({ workspace = "4" }))
hl.bind("SUPER + 5", hl.dsp.focus({ workspace = "5" }))
hl.bind("SUPER + 6", hl.dsp.focus({ workspace = "6" }))
hl.bind("SUPER + 7", hl.dsp.focus({ workspace = "7" }))
hl.bind("SUPER + 8", hl.dsp.focus({ workspace = "8" }))
hl.bind("SUPER + 9", hl.dsp.focus({ workspace = "9" }))
hl.bind("SUPER + 0", hl.dsp.focus({ workspace = "10" }))
hl.bind("SUPER + GRAVE", hl.dsp.workspace.toggle_special("special"))

hl.bind("SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = "1" }))
hl.bind("SUPER + SHIFT + 2", hl.dsp.window.move({ workspace = "2" }))
hl.bind("SUPER + SHIFT + 3", hl.dsp.window.move({ workspace = "3" }))
hl.bind("SUPER + SHIFT + 4", hl.dsp.window.move({ workspace = "4" }))
hl.bind("SUPER + SHIFT + 5", hl.dsp.window.move({ workspace = "5" }))
hl.bind("SUPER + SHIFT + 6", hl.dsp.window.move({ workspace = "6" }))
hl.bind("SUPER + SHIFT + 7", hl.dsp.window.move({ workspace = "7" }))
hl.bind("SUPER + SHIFT + 8", hl.dsp.window.move({ workspace = "8" }))
hl.bind("SUPER + SHIFT + 9", hl.dsp.window.move({ workspace = "9" }))
hl.bind("SUPER + SHIFT + 0", hl.dsp.window.move({ workspace = "10" }))
hl.bind("SUPER + SHIFT + GRAVE", hl.dsp.window.move({ workspace = "special:special" }))

hl.bind("SUPER + CONTROL + LEFT", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + CONTROL + RIGHT", hl.dsp.window.move({ direction = "r" }))
hl.bind("SUPER + CONTROL + UP", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + CONTROL + DOWN", hl.dsp.window.move({ direction = "d" }))

hl.bind("SUPER + SHIFT + LEFT", hl.dsp.window.resize({ x = -200, y = 0, relative = true }))
hl.bind("SUPER + SHIFT + RIGHT", hl.dsp.window.resize({ x = 200, y = 0, relative = true }))
hl.bind("SUPER + SHIFT + UP", hl.dsp.window.resize({ x = 0, y = -200, relative = true }))
hl.bind("SUPER + SHIFT + DOWN", hl.dsp.window.resize({ x = 0, y = 200, relative = true }))
hl.bind("SUPER + SHIFT + CONTROL + LEFT", hl.dsp.window.resize({ x = -20, y = 0, relative = true }))
hl.bind("SUPER + SHIFT + CONTROL + RIGHT", hl.dsp.window.resize({ x = 20, y = 0, relative = true }))
hl.bind("SUPER + SHIFT + CONTROL + UP", hl.dsp.window.resize({ x = 0, y = -20, relative = true }))
hl.bind("SUPER + SHIFT + CONTROL + DOWN", hl.dsp.window.resize({ x = 0, y = 20, relative = true }))

hl.bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "e+1" }))

hl.bind("SUPER + mouse:272", hl.dsp.window.drag())
hl.bind("SUPER + SHIFT + mouse:272", hl.dsp.window.resize())
hl.bind("SUPER + mouse:273", hl.dsp.window.resize())

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume 2"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume -2"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"))

hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("swayosd-client --playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("swayosd-client --playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("swayosd-client --playerctl previous"))
hl.bind("SUPER +XF86AudioRaiseVolume", hl.dsp.exec_cmd("brightnessctl -d 'intel_backlight' set +10%"))
hl.bind("SUPER + XF86AudioLowerVolume", hl.dsp.exec_cmd("brightnessctl -d 'intel_backlight' set 10%-"))
hl.bind("SUPER + XF86AudioPlay", hl.dsp.exec_cmd("~/dotfiles/scripts/audio_changer.py"))

hl.bind("SUPER + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind("SUPER + escape", hl.dsp.exec_cmd("wlogout -b 2 -m 160"))
hl.bind("SUPER + V", hl.dsp.exec_cmd("~/dotfiles/scripts/cliphist.sh"))
hl.bind("SUPER + SHIFT + V", hl.dsp.exec_cmd("~/dotfiles/scripts/cliphist-img.sh"))
hl.bind("SUPER + S", hl.dsp.exec_cmd("pkill -SIGUSR1 wayscriber"))
