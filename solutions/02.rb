def grow(snake, direction)
  first = [snake[-1][0] + direction[0], snake[-1][1] + direction[1]]
  snake + [first]
end

def move(snake, direction)
  grow(snake, direction) - [snake[0]]
end

def is_obstacle?(snake, position, dimensions)
  if snake.include? position
    true
  elsif position[0] < 0 or position[0] >= dimensions[:width]
    true
  elsif position[1] < 0 or position[1] >= dimensions[:height]
    true
  else
    false
  end
end

def obstacle_ahead?(snake, direction, dimensions)
  first = [snake[-1][0] + direction[0], snake[-1][1] + direction[1]]

  is_obstacle?(snake, first, dimensions)
end

def danger?(snake, direction, dimensions)
  obstacle_ahead?(snake, direction, dimensions) or
  obstacle_ahead?(move(snake, direction), direction, dimensions)
end

def new_food(food, snake, dimensions)
  first = (0..dimensions[:width]-1).to_a.sample
  second = (0..dimensions[:height]-1).to_a.sample
  if snake.include? [first, second] or food.include? [first, second]
    new_food(food, snake, dimensions)
  else
    [first,second]
  end
end
