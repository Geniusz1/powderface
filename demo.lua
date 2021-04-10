require('scripts.Powderface.Powderface')

local mw, mh = 420, 274
local mx, my = gfx.WIDTH/2 - mw/2, gfx.HEIGHT/2 - mh/2
local mx2, my2 = mx + mw, my + mh

local main = ui.container()

local window = ui.box(mx, my, mw, mh)

local input = ui.inputbox(mx + 10, my + 10, 100, 0, 'This is an inputbox')

local files = ui.list(mx + 10, my + 34, 100, 175)

local text = ui.text(input.x2 + 10, my + 14, 'Powderface v1.0, TPT user interface library made by Geniusz1', 0, 255, 0)
local text2 = ui.text(input.x2 + 10, text.y2 + 10, 'This is a text')
local text3 = ui.text(input.x2 + 10, text2.y2 + 10, 'This is also a text, but with a different color', 80, 150, 200)

local button = ui.button(input.x2 + 10, text3.y2 + 10, 0, 0, 'Click me!', function() print('Yay!') end)
local button2 = ui.button(button.x2 + 10, text3.y2 + 10, 80, 25, 'I\'m fancy!', function() print('Wooo!') end, 0, 255, 255)
local button3 = ui.button(button2.x2 + 10, text3.y2 + 10, 0, 0, 'I\'m disabled :(', function() print('Wooo!') end)
local button4 = ui.flat_button(text2.x2 + 10, text.y2 + 5, 60, 20, 'I\'m flat', function() print('Flattered!') end)

button3:set_enabled(false)

local check = ui.checkbox(files.x2 + 10, button2.y2 + 10, 'Disable the button')
local check2 = ui.checkbox(files.x2 + 10, check.y2 + 5, 'Draw list item separators', 255, 255, 0)

local switch = ui.switch(files.x2 + 7, check2.y2 + 5, 'Get ready for switches!')
local switch2 = ui.switch(files.x2 + 7, switch.y2 + 5, 'Yay!')
local switch3 = ui.switch(files.x2 + 7, switch2.y2 + 5, 'I\'m colorful!', 255, 255, 255, true)
local switch4 = ui.switch(files.x2 + 7, switch3.y2 + 5, 'I\'m magenta!', 255, 0, 255)

local radio = ui.radio_button(files.x2 + 150, button2.y2 + 10, 'We are radio buttons!')
local radio1 = ui.radio_button(files.x2 + 150, radio.y2 + 4, 'Isn\'t it beautiful')
local radio2 = ui.radio_button(files.x2 + 150, radio1.y2 + 4, 'It sure is')
local radio3 = ui.radio_button(files.x2 + 150, radio2.y2 + 4, 'Yeah')

local radiob = ui.radio_button(files.x2 + 150, radio3.y2 + 10, 'We are of a different group', 255, 0, 0)
local radiob2 = ui.radio_button(files.x2 + 150, radiob.y2 + 4, 'It\'s so user-friendly', 255, 0, 0)

local rgroup = ui.radio_group(radio, radio1, radio2, radio3)
local rgroup2 = ui.radio_group(radiob, radiob2)

local textscrollllll = ui.scroll_text(files.x2 + 100, radiob.y2 + 84, 100, 'This is it, it being not only a text box, yet also a scrolltext box', 'right')
local textscrollllllBox = ui.box(files.x2 + 6, radiob.y2 + 80, 110, textscrollllll.h + 5)

local progress = ui.progressbar(files.x2 + 10, radiob.y2 + 24, 200, 10, true)
progress:set_progress(50)

local slider = ui.slider(files.x2 + 10, radiob.y2 + 54, 100, -100, 100, 10)

local value = ui.text(files.x2 - 20, radiob.y2 + 54, slider.value)

rgroup:set_selected(1)
textscrollllll:set_scroll_pos(4)

check:set_checked(true)

files:append(ui.text(files.x, files.y, 'This is a list'))

for i = 2, 24 do   
    local item = ui.flat_button(files.x, files.y, 40, 15, 'butt '..i, function() print('item '..i..' clicked') end)
    files:append(item)
end

main:append(
    window,
    input,
    files,
    text,
    text2,
    text3,
    button,
    button2,
    button3,
    button4,
    check,
    check2,
    switch,
    switch2,
    switch3,
    switch4,
    rgroup,
    rgroup2,
    textscrollllll,
    textscrollllllBox,
    progress,
    slider,
    value
)

window.draw_background = true

local enabled = true

local function tick()
    if enabled then
        gfx.fillRect(0, 0, gfx.WIDTH, gfx.HEIGHT, 0, 0, 0, 140)
        main:draw()
        button3:set_enabled(not check.checked)
        button3.label:set_text(check.checked and 'I\'m disabled :(' or 'I\'m enabled :D')
        files.draw_separator = check2.checked
        value:set_text(slider.value)
    end
end

local function mouseup(x, y, button, reason)
    if enabled then
        main:handle_event('mouseup', x, y, button, reason)
        return false  
    end
end

local function mousemove(x, y, dx, dy)
    if enabled then
        main:handle_event('mousemove', x, y, dx, dy)
        return false  
    end
end

local function mousedown(x, y, button)
    if enabled then
        main:handle_event('mousedown', x, y, button)
        return false  
    end
end
local function mousewheel(x, y, d)
    if enabled then
        main:handle_event('mousewheel', x, y, d)
        return false  
    end
end


local function keypress(key, scan, rep, shift, ctrl, alt)
    if enabled then
        main:handle_event('keypress', key, scan, rep, shift, ctrl, alt)
        if scan == 41 then enabled = false end
        return false 
    end
end

local function textinput(text)
    main:handle_event('textinput', text)
end


evt.register(evt.keypress, keypress)
evt.register(evt.tick, tick)
evt.register(evt.mouseup, mouseup)
evt.register(evt.mousedown, mousedown)
evt.register(evt.mousemove, mousemove)
evt.register(evt.textinput, textinput)
evt.register(evt.mousewheel, mousewheel)