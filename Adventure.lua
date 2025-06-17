print("Welcome to the Lua Adventure!")
print("You wake up in a dark room. There is a door to the NORTH and a window to the EAST.")
print("What do you want to do? (north/east)")

local choice = io.read()

if choice == "north" then
    print("You opened the door and find a treasure chest! You win!")
elseif choice == "east" then
    print("You jump out the window and land in a bush. Ouch, you lose!")
else
    print("You stand still and nothing happens. Try again next time.")
end
