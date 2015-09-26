/c
local out = ""

function write(...)
  local arg = {...}
  for i, v in ipairs(arg) do
    out = out .. tostring(v)
  end
end

function item_count(node)
  local count = 0
  for k, v in pairs(node) do
    count = count + 1
  end
  return count
end

function traverse_table(node)
  write("{")
  local i = 1
  local count = item_count(node)
  for k, v in pairs(node) do
    write("\"", tostring(k), "\": ")
    traverse(v)
    if i < count then
      write(",")
    end
    i = i + 1
  end
  write("}")
end

function traverse_array(node)
  local count = item_count(node)
  write("[")
  for k, v in ipairs(node) do
    traverse(v)
    if k < count then
      write(",")
    end
  end
  write("]")
end

function traverse(node)
  if type(node) == "table" then
    if type(next(node)) == "number" then
      traverse_array(node)
    else
      traverse_table(node)
    end
  elseif type(node) == "string" then
    write("\"", node, "\"")
  else
    write(node)
  end
end

function inspect_recipe(node)
  return {
    name=node.name,
    category=node.category,
    products=node.products,
    ingredients=node.ingredients,
    hidden=node.hidden,
    energy=node.energy,
    order=node.order
  }
end


function inspect_all(recipes)
  local r = {}
  for k, v in pairs(recipes) do
    r[k] = inspect_recipe(v)
  end
  traverse(r)
end

inspect_all(game.player.force.recipes)

game.makefile("recipes", out)