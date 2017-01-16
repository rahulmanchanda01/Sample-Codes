#Data visu with ggvis

install.packages("ggvis")
library(ggvis)
View(mtcars)
mtcars %>% ggvis(~disp, ~wt) %>% layer_points() %>% layer_smooths()
mtcars %>% ggvis(~disp, ~wt) %>% layer_densities()
mtcars %>% ggvis(~disp, ~wt) %>% layer_paths()
mtcars %>% ggvis(~disp, ~wt) %>% layer_smooths()
mtcars %>% ggvis(~disp, ~wt, fill := "blue") %>% layer_points() %>% layer_smooths()

mtcars %>% ggvis(~mpg, ~wt, fill = ~cyl) %>% layer_points() %>% layer_smooths()
mtcars %>% ggvis(~mpg, ~wt, fill = ~cyl ,size = ~disp) %>% layer_points() 
View(pressure)
pressure %>% ggvis(~temperature, ~pressure, size = ~pressure) %>% layer_points()

#distinction between := and =

#Other symbols
pressure %>% 
  ggvis(~temperature, ~pressure, size = ~pressure, fill := "red", shape := "guess", stroke := "red") %>% 
  layer_points()

mtcars %>% compute_smooth(mpg ~ wt) %>% ggvis(~pred_, ~resp_) %>% layer_lines()
mtcars %>% ggvis(~mpg, ~ wt) %>% layer_lines()
mtcars %>% ggvis(~wt, ~mpg) %>% layer_smooths() %>% layer_points()
mtcars %>% ggvis(~mpg) %>% layer_histogramswidth=3
mtcars %>% ggvis(~mpg) %>% layer_densities()

#GGVIS and DPLYR
mtcars %>% group_by(cyl) %>% ggvis(~mpg, ~wt, stroke = ~factor(cyl)) %>% layer_smooths()
mtcars %>% group_by(cyl) %>% ggvis(~mpg, fill = ~factor(cyl)) %>% layer_densities()
mtcars %>% group_by(cyl, am) %>% ggvis(~mpg, fill = ~interaction(cyl, am)) %>% layer_densities()

#Interactive ggivs plots
mtcars %>%
  ggvis(~mpg, ~wt,
        fill := input_radiobuttons(label = "Choose color:",
                                   choices = c("black", "red", "blue", "green"))) %>%
  layer_points()

# Map the fill property to a select box that returns variable names
mtcars %>%
  ggvis(~mpg, ~wt,
        fill = input_select(label = "Choose fill variable:",
                            choices = names(mtcars), map = as.name)) %>%
  layer_points()

# Map the binwidth to a slider bar ("Choose a binwidth:")
mtcars %>%
  ggvis(~mpg) %>%
  layer_histograms(width = input_slider(label = "Choose a binwidth:", min = 1, max = 20))

# Change the axes of the plot as instructed
faithful %>% 
  ggvis(~waiting, ~eruptions) %>% 
  layer_points() %>% 
  add_axis("x", 
           title = "Time since previous eruption (m)", 
           values = c(50, 60, 70, 80, 90), 
           subdivide = 9,
           orient = "top") %>%
  add_axis("y", 
           title = "Duration of eruption (m)", 
           values = c(2, 3, 4, 5), 
           subdivide = 9,
           orient = "right")

# Add a legend
faithful %>% 
  ggvis(~waiting, ~eruptions, opacity := 0.6, 
        fill = ~factor(round(eruptions))) %>% 
  layer_points() %>% 
  add_legend("fill", title = "~ duration (m)", orient = "left")

# Fix the legend
faithful %>% 
  ggvis(~waiting, ~eruptions, opacity := 0.6, 
        fill = ~factor(round(eruptions)), shape = ~factor(round(eruptions)), 
        size = ~round(eruptions)) %>% 
  layer_points() %>% 
  add_legend(c("fill", "shape", "size"), 
             title = "~ duration (m)")


# Add a scale_numeric()
mtcars %>% 
  ggvis(~wt, ~mpg, fill = ~disp, stroke = ~disp, strokeWidth := 2) %>%
  layer_points() %>%
  scale_numeric("fill", range = c("red", "green")) %>%
  scale_numeric("stroke", range = c("red", "green"))


# Add a scale_numeric()
mtcars %>% ggvis(~wt, ~mpg, fill = ~hp) %>%
  layer_points() %>%
  scale_numeric("fill", range = c("green", "beige"))

# Add a scale_nominal()
mtcars %>% ggvis(~wt, ~mpg, fill = ~factor(cyl)) %>%
  layer_points() %>%
  scale_nominal("fill", range = c("purple", "blue", "green"))

# Add a second scale to set domain for x
mtcars %>% ggvis(~wt, ~mpg, fill = ~disp) %>%
  layer_points()
  scale_numeric("y", domain = c(0, NA))

  
#--------------------------------------------------------------------------------
  
#Base R Grpahics
  
plot(mtcars)
library(MASS)  
  
  # Plot Gas vs. Temp
  plot(whiteside$Temp, whiteside$Gas,
       xlab = "Outside temperature",
       ylab = "Heating gas consumption")
plot(whiteside$Insul)

par(mfrow = c(1,2))
plot(Cars93$Price, Cars93$Min.Price, pch=16, col="red")
title("first graph")
plot(Cars93$Price, Cars93$Min.Price, pch=10, col="blue")
title("Second graph")
points(Cars93$Price, Cars93$Min.Price,pch = 16, col = "blue")
abline(a = 0, b = 1, lty = 2)


par(mfrow = c(2,3))
tbl <- sort(table(Cars93$Origin), decreasing = TRUE)
pie(tbl)
title("First Pie")
tbl <- sort(table(Cars93$Manufacturer), decreasing = TRUE)
pie(tbl)
title("Second Pie")
tbl <- sort(table(Cars93$Type), decreasing = TRUE)
pie(tbl)
title("Third Pie")
barplot(tbl, las=2)
title("Bar chart")

par(mfrow = c(1,2))
hist(Cars93$Price)
truehist(Cars93$Price)

library(car)
# Create index16, pointing to 16-week chicks
index16 <- which(Cars93$Price == 16)
# Get the 16-week chick weights
weights <- Cars93$Price[index16]
# Show the normal QQ-plot of the chick weights
qqPlot(weights)
boxplot(Cars93$Price ~ Cars93$Type, las=2, log ="y")
mosaicplot(carb ~ cyl, data = mtcars)

# Load the corrplot library for the corrplot() function
library(corrplot)
# Extract the numerical variables from UScereal
numericalVars <- UScereal[, 2:10]
# Compute the correlation matrix for these variables
corrMat <- cor(numericalVars)
# Generate the correlation ellipse plot
corrplot(corrMat, method = "ellipse")

#___________________________________________________________________________
 
#Geospatial data

install.packages("ggmap")
library(ggmap)
corvallis <- c(lon = 17.12  , lat = 32.38 )
map_5 <- get_map(corvallis, zoom = 3, scale = 1)
ggmap(map_5)
corvallis_map <- get_map(corvallis, zoom = 13, scale = 1)
ggmap(corvallis_map)

  geom_point(aes(longitude, Latitude), data = Sales)
  # Use base_layer argument to ggmap() to specify data and x, y mappings
  ggmap(corvallis_map_bw) +
    geom_point(aes(lon, lat, color = year_built), data = sales)
  
  # Use base_layer argument to ggmap() and add facet_wrap()
  ggmap(corvallis_map_bw) +
    geom_point(aes(lon, lat, color = class), data = sales)
  
  
#___________________________________________________________________________
  
#GGPLOT

library(ggplot2)
str(mtcars)
View(mtcars)
args(ggplot)

ggplot(mtcars, aes(x=cyl, y=mpg)) +geom_point()
ggplot(mtcars, aes(x=factor(cyl), y=mpg)) +geom_point()
ggplot(mtcars, aes(x=wt, y=mpg, size = disp)) +geom_point()

#base packagae function
plot(mtcars$disp, mtcars$mpg, col=mtcars$disp, type = "p")

# Convert cyl to factor (don't need to change)
mtcars$cyl <- as.factor(mtcars$cyl)

# Example from base R (don't need to change)
plot(mtcars$wt, mtcars$mpg, col = mtcars$cyl)
abline(lm(mpg ~ wt, data = mtcars), lty = 2)
lapply(mtcars$cyl, function(x) {
  abline(lm(mpg ~ wt, mtcars, subset = (cyl == x)), col = x)
})
legend(x = 5, y = 33, legend = levels(mtcars$cyl),
       col = 1:3, pch = 1, bty = "n")


# Plot 3: include a lm for the entire dataset in its whole
ggplot(mtcars, aes(x = wt, y = mpg, col = cyl)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  geom_smooth(aes(group = 1), method = "lm", se = FALSE, linetype = 2)

iris
library(tidyr)
iris.tidy <- iris %>%
  gather(key, Value, -Species) %>%
  separate(key, c("Part", "Measure"), "\\.")
#-----------------------------------------------------
# Given from the previous exercise
ggplot(mtcars, aes(x = wt, y = mpg, col = cyl)) +
  geom_point(shape = 1, size = 4)

# Map cyl to fill
ggplot(mtcars, aes(x = wt, y = mpg, fill = cyl)) +
  geom_point()

# Change shape, size and alpha of the points in the above plot
ggplot(mtcars, aes(x = wt, y = mpg, fill = cyl)) +
  geom_point(shape = 16, size = 6, alpha = 0.6)

# Map cyl to size
ggplot(mtcars, aes(x = wt, y = mpg, size = cyl)) +
  geom_point()

# Map cyl to alpha
ggplot(mtcars, aes(x = wt, y = mpg, alpha = cyl)) +
  geom_point()

# Map cyl to shape 
ggplot(mtcars, aes(x = wt, y = mpg, shape = cyl)) +
  geom_point()

# Map cyl to labels
ggplot(mtcars, aes(x = wt, y = mpg, label = cyl)) +
  geom_text()
# Define a hexadecimal color
my_color <- "#123456"

# Set the color aesthetic 
ggplot(mtcars, aes(x = wt, y = mpg, col = cyl)) +
  geom_point()

# Set the color aesthetic and attribute 
ggplot(mtcars, aes(x = wt, y = mpg, col = cyl)) +
  geom_point(col = my_color)

# Set the fill aesthetic and color, size and shape attributes
ggplot(mtcars, aes(x = wt, y = mpg, fill = cyl)) +
  geom_point(size = 10, shape = 23, col = my_color)
# Expand to draw points with alpha 0.5
ggplot(mtcars, aes(x = wt, y = mpg, fill = cyl)) +
  geom_point(alpha = 0.5)

# Expand to draw points with shape 24 and color yellow
ggplot(mtcars, aes(x = wt, y = mpg, fill = cyl)) +
  geom_point(shape = 24, color = 'yellow')

# Expand to draw text with label x, color red and size 10
ggplot(mtcars, aes(x = wt, y = mpg, fill = cyl)) +
  geom_text(label = "ggplot2", color = 'red', size = 3)
# Map mpg onto x, qsec onto y and factor(cyl) onto col
ggplot(mtcars, aes(x = mpg, y = qsec, col = factor(cyl))) +
  geom_point()

# Add mapping: factor(am) onto shape
ggplot(mtcars, aes(x = mpg, y = qsec, col = factor(cyl), shape = factor(am))) +
  geom_point()

# Add mapping: (hp/wt) onto size
ggplot(mtcars, aes(x = mpg, y = qsec, col = factor(cyl), shape = factor(am), size = (hp/wt))) +
  geom_point()

ggplot(mtcars,aes(x=mpg, y=qsec)) + 
  geom_point() +
  scale_x_continuous(name = "MPG(miles per gallon)"  ) +
  scale_y_continuous(name = "QSEC(dont know what that is")
  
# Basic scatter plot of wt on x-axis and mpg on y-axis; map cyl to col
ggplot(mtcars, aes(x = wt, y = mpg, col = cyl)) +
  geom_point(size = 4)

# Hollow circles - an improvement
ggplot(mtcars, aes(x = wt, y = mpg, col = cyl)) +
  geom_point(size = 4, shape = 1)

# Add transparency - very nice
ggplot(mtcars, aes(x = wt, y = mpg, col = cyl)) +
  geom_point(size = 4, alpha = 0.6)

  


# Scatter plot: carat (x), price (y), clarity (col)
ggplot(diamonds, aes(x = carat, y = price, col = clarity)) +
  geom_point()

# Adjust for overplotting
ggplot(diamonds, aes(x = carat, y = price, col = clarity)) +
  geom_point(alpha = 0.5)

# Scatter plot: clarity (x), carat (y), price (col)
ggplot(diamonds, aes(x = clarity, y = carat, col = price)) +
  geom_point(alpha = 0.5)

# Dot plot with jittering
ggplot(diamonds, aes(x = clarity, y = carat, col = price)) +
  geom_point(alpha = 0.5, position = "jitter")

# Examine the structure of Vocab
str(Vocab)

# Make a univariate histogram
ggplot(mtcars, aes(mpg)) +
  geom_histogram()

# Change the bin width to 1
ggplot(mtcars, aes(mpg)) +
  geom_histogram(binwidth = 1)

# Change the y aesthetic to density
ggplot(mtcars, aes(mpg)) +
  geom_histogram(aes(y=..density..), binwidth = 1)

# Custom color code
myBlue <- "#377EB8"

# Change the fill color to myBlue
ggplot(mtcars, aes(mpg)) +
  geom_histogram(aes(y = ..density..),
                 binwidth = 1, fill = myBlue)
# Draw a bar plot of cyl, filled according to am
ggplot(mtcars, aes(x = cyl, fill = am)) +
  geom_bar()

# Change the position argument to "stack""
ggplot(mtcars, aes(x = cyl, fill = am)) +
  geom_bar(position = "stack")

# Change the position argument to "fill""
ggplot(mtcars, aes(x = cyl, fill = am)) +
  geom_bar(position = "fill") 

# Change the position argument to "dodge""
ggplot(mtcars, aes(x = cyl, fill = am)) +
  geom_bar(position = "dodge")

# Draw a bar plot of cyl, filled according to am
ggplot(mtcars, aes(x = cyl, fill = am)) + 
  geom_bar()

# Change the position argument to "dodge"
ggplot(mtcars, aes(x = cyl, fill = am)) + 
  geom_bar(position = "dodge")

# Define posn_d with position_dodge()
posn_d <- position_dodge(0.2)

# Change the position argument to posn_d
ggplot(mtcars, aes(x = cyl, fill = am)) + 
  geom_bar(position = posn_d)

# Use posn_d as position and adjust alpha to 0.6
ggplot(mtcars, aes(x = cyl, fill = am)) + 
  geom_bar(position = posn_d, alpha = 0.6)

# Example of how to use a brewed color palette
ggplot(mtcars, aes(x = cyl, fill = am)) +
  geom_bar() +
  scale_fill_brewer(palette = "Set1")

# Final plot of last exercise
ggplot(Vocab, aes(x = education, fill = vocabulary)) +
  geom_bar(position = "fill") +
  scale_fill_brewer()

# Definition of a set of blue colors
blues <- brewer.pal(9, "Blues")

# Make a color range using colorRampPalette() and the set of blues
blue_range <- colorRampPalette(blues)

# Use blue_range to adjust the color of the bars, use scale_fill_manual()
ggplot(Vocab, aes(x = education, fill = vocabulary)) +
  geom_bar(position = "fill") +
  scale_fill_manual(values = blue_range(11))

attach(economics)

# Expand the following command with geom_rect() to draw the recess periods
ggplot(economics, aes(x = date, y = unemploy/pop)) +
  geom_line() +
  geom_rect(data = recess, 
            aes(xmin = begin, xmax = end, ymin = -Inf, ymax = +Inf), 
            inherit.aes = FALSE, fill = "red", alpha = 0.2)

#QPLOT - quick and dirty way by ggplot2 with lots of defaults

#________________________________________________________________________-

ggplot(mtcars, aes(x = wt, y = mpg)) +
  stat_smooth(method = "lm", se = F)

# Define cyl as a factor variable
ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) +
  geom_point() +
  stat_smooth(method = "lm", se = F)


# Complete the following ggplot command as instructed
ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) +
  geom_point() +
  stat_smooth(method = "lm", se = F) +
  stat_smooth(method = "lm", se = F, aes(group = 1))

# Plot 4: Add scale_color_manual to change the colors
myColors <- c(brewer.pal(3, "Dark2"), "black")
ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) +
  geom_point() +
  stat_smooth(method = "lm", se = F, span = 0.75) +
  stat_smooth(method = "loess", 
              aes(group = 1, col="All"), 
              se = F, span = 0.7) +
  # Add correct arguments to scale_color_manual
  scale_color_manual("Cylinders", values = myColors)


# Basic ggplot() command, coded for you
p <- ggplot(mtcars, aes(x = wt, y = hp, col = am)) + geom_point() + geom_smooth()

# Add scale_x_continuous
p + 
  scale_x_continuous(limits = c(3, 6), expand = c(0, 0))

# Add coord_cartesion: the proper way to zoom in:
p +
  coord_cartesian(xlim = c(3, 6))

# Complete basic scatter plot function
base.plot <- ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, col = Species)) +
  geom_jitter() +
  geom_smooth(method = "lm", se = F)

# Plot base.plot: default aspect ratio
base.plot

# Fix aspect ratio (1:1) of base.plot
base.plot + coord_equal()
# or
base.plot + coord_fixed()


# Basic scatter plot:
p <- ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point()

# Separate rows according to transmission type, am
p +
  facet_grid(am ~ .)

# Separate columns according to cylinders, cyl
p +
  facet_grid(. ~ cyl)

# Separate by both columns and rows 
p +
  facet_grid(am ~ cyl)

# Code to create the cyl_am col and myCol vector
mtcars$cyl_am <- paste(mtcars$cyl, mtcars$am, sep = "_")
myCol <- rbind(brewer.pal(9, "Blues")[c(3,6,8)],
               brewer.pal(9, "Reds")[c(3,6,8)])

# Basic scatter plot, add color scale:
ggplot(mtcars, aes(x = wt, y = mpg, col = cyl_am)) +
  geom_point() +
  scale_color_manual(values = myCol)

# Facet according on rows and columns.
ggplot(mtcars, aes(x = wt, y = mpg, col = cyl_am)) +
  geom_point() +
  scale_color_manual(values = myCol) +
  facet_grid(gear ~ vs)

# Add more variables
ggplot(mtcars, aes(x = wt, y = mpg, col = cyl_am, size = disp)) +
  geom_point() +
  scale_color_manual(values = myCol) +
  facet_grid(gear ~ vs)

# Basic scatter plot
ggplot(mamsleep, aes(x = time, y = name, col = sleep)) +
  geom_point()

# Facet rows accoding to vore
ggplot(mamsleep, aes(x = time, y = name, col = sleep)) +
  geom_point() +
  facet_grid(vore ~ .)

# Specify scale and space arguments to free up rows
ggplot(mamsleep, aes(x = time, y = name, col = sleep)) +
  geom_point() +
  facet_grid(vore ~ ., scale = "free_y", space = "free_y")


# Load ggthemes package
library(ggthemes)

# Apply theme_tufte
# Set the theme with theme_set
theme_set(theme_tufte())
z2 + 
  # Or apply it in the ggplot command
  theme_tufte()

# Apply theme_tufte, modified
# Set the theme with theme_set
theme_set(theme_tufte() + 
            theme(legend.position = c(0.9, 0.9),
                  legend.title = element_text(face = "italic", size = 12),
                  axis.title = element_text(face = "bold", size = 14)))
z2 + 
  # Or apply it in the ggplot command
  theme_tufte() +
  theme(legend.position = c(0.9, 0.9),
        legend.title = element_text(face = "italic", size = 12),
        axis.title = element_text(face = "bold", size = 14))


#PROJECT

# Plot 1 - Count histogram
ggplot(adult, aes (x = SRAGE_P, fill= factor(RBMI))) + 
  geom_histogram(binwidth = 1) +
  BMI_fill

# Plot 2 - Density histogram
ggplot(adult, aes (x = SRAGE_P, fill= factor(RBMI))) + 
  geom_histogram(aes(y = ..density..), binwidth = 1) +
  BMI_fill



# Plot 4 - Faceted density histogram
ggplot(adult, aes(x = SRAGE_P, fill= factor(RBMI))) + 
  geom_histogram(aes(y = ..density..), binwidth = 1) +
  BMI_fill + 
  facet_grid(RBMI ~ .)

# Plot 5 - Density histogram with position = "fill"
ggplot(adult, aes(x = SRAGE_P, fill= factor(RBMI))) + 
  geom_histogram(aes(y = ..density..), binwidth = 1, position = "fill") +
  BMI_fill

# Plot 6 - The accurate histogram
ggplot(adult, aes (x = SRAGE_P, fill= factor(RBMI))) + 
  geom_histogram(aes(y = ..count../sum(..count..)), binwidth = 1, position = "fill") +
  BMI_fill