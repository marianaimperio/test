#R for data science

#Instalando o package que o livro vai usar
install.packages("tidyverse")
library(tidyverse)

#Instalando as bases de dados.
install.packages(c("nycflights13", "gapminder", "Lahman"))
mtcars <-dput(mtcars)

#Plotando o tamanho do motor no eixo x e o seu consumo de combustível no eixo y
#Stroke muda a grossura da estética escolhida -> cor, shape ou tamanho normalmente
ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=hwy))
ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=hwy, color = class))
ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=hwy, size = class))
ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=hwy, alpha = class))
ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=hwy, shape = class, stroke = 3))

ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=hwy, color = displ, stroke=1))
ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=hwy, size = displ, stroke=1))
ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=hwy, shape = displ))
ggplot(data=mpg) + geom_point(mapping=aes(x=displ, y=hwy, color = displ<=5))

#Template do ggplot
#ggplot(data= <DATA>)+ <geom_FUNCTION>(mapping= aes(<MAPPINGS>)))

#plotando hwy x cyl
ggplot(data=mpg) + geom_point(mapping=aes(x=hwy, y=cyl))
#class x drv
ggplot(data=mpg) + geom_point(mapping=aes(x=class, y=drv))

#3.5 Facets
#variável do face_wrap tem que ser discreta. 
ggplot(data=mpg) + 
  geom_point(mapping=aes(x=displ, y=hwy)) +
  facet_wrap(~ class, nrow=2)

#Combinação de 2 variáveis -> face_grid
ggplot(data=mpg) + 
  geom_point(mapping=aes(x=displ, y=hwy)) +
  facet_grid(drv ~ cyl)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl))

ggplot(data=mpg) + 
  geom_point(mapping=aes(x=displ, y=hwy)) +
  facet_wrap(~ displ, nrow=2)

#3.6 Geometrical objects
ggplot(data=mpg) + geom_smooth(mapping=aes(x=displ, y=hwy))

#diferenciando
ggplot(data=mpg) + geom_smooth(mapping=aes(x=displ, y=hwy, linetype = drv, color = drv))

#duas estéticas no mesmo plot
ggplot(data=mpg) + 
  geom_point(mapping =aes(x=displ, y=hwy)) + 
  geom_smooth(mapping=aes(x=displ, y=hwy))
 #Forma mais eficiente
ggplot(data=mpg, mapping =aes(x=displ, y=hwy)) + 
  geom_point() + 
  geom_smooth()

#Mudando a estética de apenas um das categorias -> colocando pontos coloridos.  
ggplot(data=mpg, mapping =aes(x=displ, y=hwy)) + 
  geom_point(mapping =aes(color = class)) + 
  geom_smooth()

ggplot(data=mpg, mapping =aes(x=displ, y=hwy)) + 
  geom_point(mapping =aes(color = class)) + 
  geom_smooth(data = filter(mpg, class =="subcompact"), se=F)

#Exercises
ggplot(data=mpg, mapping =aes(x=displ, y=hwy)) + 
  geom_point()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv), show.legend=FALSE) + 
  geom_point() + 
  geom_smooth(se=F)

#1
ggplot(data = mpg, mapping = aes(x = displ, y = hwy,show.legend=FALSE)) + 
  geom_point(stroke=3) + 
  geom_smooth(se=F)

#2
ggplot(data = mpg, mapping = aes(x = displ, y = hwy,colo = drv, show.legend=FALSE)) + 
  geom_point(stroke=3) + 
  geom_smooth(se=F)

#3
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point(stroke=3) + 
  geom_smooth(se=F)
#4
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, show.legend=TRUE)) + 
  geom_point(mapping = aes(color = drv, stroke=3)) + 
  geom_smooth(se=F)
#5
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, show.legend=TRUE)) + 
  geom_point(mapping = aes(color = drv, stroke=3)) + 
  geom_smooth(mapping = aes(linetype=drv),se=F)

#6
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, show.legend=TRUE)) + 
  geom_point(mapping = aes(color = drv,stroke=3)) 
  #geom_smooth(mapping = aes(linetype=drv),se=F)

#3.7 Statistical transformations
#barplot simples
ggplot(diamonds) +
  geom_bar(mapping = aes(x=cut))


# necessidade de usar o stat do geom diretamente
#1 
demo <- tribble(
  ~a,       ~b,
  "bar_1", 20, 
  "bar_2", 30,
  "bar_3", 40
)

ggplot(demo) + 
  geom_bar(mapping=aes(x=a, y=b), stat="identity")

#2 Proporções
ggplot(diamonds) +
  geom_bar(mapping = aes(x=cut, y=..prop.., group=1))

#3 
ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )
  


ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))
  geom_ribbon(ymin = min, ymax= max, y=median(diamonds$depth))


list <- tribble(
  ~g,      ~s,
  "ribbon", "identity",
  "area", "identity",
  "bar", "count",
  "bin2d", "bin2d",
  "blank", "identity",
  "boxplot","boxplot",
  "col", "count",
  "contour", "contour",
  "count", "sum", 
  "crossbar", "identity", 
  "curve", "identity"
  
)

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop.., group=1))

#ggplot(data = diamonds) + 
 # geom_bar(mapping = aes(x = cut, fill = cut, y = ..prop.., group=1))
#N~ao consegui identificar o problema.

#3.8
ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) + 
  geom_bar(fill=NA, position = "identity")

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point(position = "jitter")
  
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")

ggplot(mpg, mapping =aes(x = manufacturer, y = displ )) +
  
  #3.9 Coordinate systems
  ggplot(data=mpg, mapping =aes(x=class, y=hwy)) + 
  geom_boxplot()+
  coord_flip()


bar <- ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = cut, fill = cut), 
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar + coord_flip()
bar + coord_polar()

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")+
  coord_polar() 

ggplot(diamonds) +
  geom_bar(mapping = aes(x=cut, y=..prop.., group=1))+
  coord_polar()

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() + 
  geom_abline() +
  coord_fixed()

#TEMPLATE PARA QUALQUER GRAFICO
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill=cut, y= ..count..))
#POSITION ajustar a posi'c~ao das informa'c~oes. 
#COORD coordenadas

#4 Workflow: basics

seq(1,10, length.out = 5)
x <- "hello world"

library(tidyverse)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

filter(mpg, cyl == 8)
filter(diamonds, carat > 3)


# 5
#filter
flights
jan1 <- filter (flights, month == 1, day==1)

filter(flights, month == 1, dep_time == 517)
