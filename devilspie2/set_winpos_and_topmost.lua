-- Window infos of applications
ELDENRING = {name = "ELDEN RING", x = 983, y = 0}
SF6 = {name = "Street Fighter 6", x = 983, y = 0}

local function set_window_position_and_topmost(window_info, should_active)
    if (get_window_name()==window_info.name) then
        debug_print("Set window_pos and topmost of window name: " .. get_window_name());
        set_window_position(window_info.x, window_info.y)
        set_window_above(should_active);
    else
        debug_print("No window exists: window name: " .. window_info.name);
    end
end

-- ELDEN RING
set_window_position_and_topmost(ELDENRING, true)
-- Street Fighter 6
set_window_position_and_topmost(SF6, true)

-- -- Visual Studio Code
-- if (get_class_instance_name()=="code") then
--     set_window_position(1007, 33)
-- end
--
-- -- Google Chrome
-- if (get_class_instance_name()=="google-chrome") then
--     set_window_position(1831, 32)
-- end
