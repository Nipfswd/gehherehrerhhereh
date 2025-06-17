-- Text Adventure Game in Lua

local player = {
    health = 100,
    inventory = {},
    name = "",
}

local function printColored(text, colorCode)
    -- ANSI escape codes for colors
    print(string.format("\27[%sm%s\27[0m", colorCode, text))
end

local function getInput(prompt)
    io.write(prompt)
    return io.read()
end

local function showInventory()
    if #player.inventory == 0 then
        print("Your inventory is empty.")
    else
        print("You have:")
        for i, item in ipairs(player.inventory) do
            print(" - " .. item)
        end
    end
end

local function addItem(item)
    table.insert(player.inventory, item)
    print("You got a " .. item .. "!")
end

local function battle(enemy)
    printColored("A wild " .. enemy.name .. " appears!", "31") -- red text
    local enemyHealth = enemy.health

    while player.health > 0 and enemyHealth > 0 do
        print("Your health:", player.health)
        print(enemy.name .. "'s health:", enemyHealth)
        local action = getInput("Attack (a) or Run (r)? ")

        if action == "a" then
            local damage = math.random(10, 20)
            enemyHealth = enemyHealth - damage
            print("You hit the " .. enemy.name .. " for " .. damage .. " damage!")

            if enemyHealth <= 0 then
                printColored("You defeated the " .. enemy.name .. "!", "32") -- green text
                return true
            end

            local enemyDamage = math.random(5, 15)
            player.health = player.health - enemyDamage
            print("The " .. enemy.name .. " hits you for " .. enemyDamage .. " damage!")

            if player.health <= 0 then
                printColored("You have been defeated! Game Over.", "31")
                os.exit()
            end

        elseif action == "r" then
            if math.random() > 0.5 then
                print("You successfully ran away!")
                return false
            else
                print("You failed to escape!")
                local enemyDamage = math.random(5, 15)
                player.health = player.health - enemyDamage
                print("The " .. enemy.name .. " hits you for " .. enemyDamage .. " damage!")
            end
        else
            print("Invalid input, try again.")
        end
    end
end

local function startAdventure()
    print("Welcome to the Lua Adventure!")
    player.name = getInput("What is your name, adventurer? ")

    print("Hello, " .. player.name .. "! Your journey begins...\n")

    print("You find yourself at a crossroads. Do you go left or right?")
    local choice = getInput("(left/right): ")

    if choice == "left" then
        print("You walk into a dark forest...")
        addItem("Magic Potion")
        local enemy = {name = "Goblin", health = 50}
        if battle(enemy) then
            print("You find a treasure chest after defeating the goblin!")
            addItem("Gold Coin")
        end

    elseif choice == "right" then
        print("You find a peaceful village and rest there.")
        player.health = player.health + 20
        print("Your health increased to " .. player.health .. ".")

    else
        print("Confused, you stand still until night falls. Game over.")
        return
    end

    showInventory()
    print("Thanks for playing, " .. player.name .. "!")
end

-- Start the game
math.randomseed(os.time())
startAdventure()
