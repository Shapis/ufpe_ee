extends Control
@export var carro: Node

@onready var chart: Chart = $VBoxContainer/Chart


# This Chart will plot 3 different functions
var f1: Function
var f2: Function
var f3: Function
var f4: Function

func _ready():
	# Let's customize the chart properties, which specify how the chart
	# should look, plus some additional elements like labels, the scale, etc...
	var cp: ChartProperties = ChartProperties.new()
	cp.colors.frame = Color("#161a1d")
	cp.colors.background = Color.TRANSPARENT
	cp.colors.grid = Color("#283442")
	cp.colors.ticks = Color("#283442")
	cp.colors.text = Color.WHITE_SMOKE
	cp.draw_bounding_box = false
	cp.title = "Velocidade das Rodas"
	cp.x_label = "milisegundos"
	cp.y_label = "mm/s"
	cp.x_scale = 5
	cp.y_scale = 10
	cp.interactive = true # false by default, it allows the chart to create a tooltip to show point values
	# and interecept clicks on the plot
	
	# Let's add values to our functions
	f1 = Function.new(
		[0], [0], "Roda Esquerda", # This will create a function with x and y values taken by the Arrays 
						# we have created previously. This function will also be named "Pressure"
						# as it contains 'pressure' values.
						# If set, the name of a function will be used both in the Legend
						# (if enabled thourgh ChartProperties) and on the Tooltip (if enabled).
		{ color = Color.GREEN, marker = Function.Marker.CIRCLE }
	)
	f2 = Function.new([0], [0], "Roda Direita", { color = Color("#ff6384"), marker = Function.Marker.CROSS })
	f3 = Function.new([0], [0], "limite superior", { color = Color("#161a1d"), marker = Function.Marker.CROSS })
	f4 = Function.new([0], [0], "limite inferior", { color = Color("#161a1d"), marker = Function.Marker.CROSS })
	
	# Now let's plot our data
	chart.plot([f1,f2,f3,f4], cp)
	
	# Uncommenting this line will show how real time data plotting works
	# set_process(false)


var tempoTotal: float = 0
var divisor: int = 0

func _process(delta: float):
	# This function updates the values of a function and then updates the plot
	tempoTotal += delta*1000
	divisor += 1	
	
	# we can use the `Function.add_point(x, y)` method to update a function
	if divisor == carro.EscalaGraph:
		f1.add_point(tempoTotal, carro._rodaEsquerdaVelocidade)
		f2.add_point(tempoTotal,  carro._rodaDireitaVelocidade)
		f3.add_point(tempoTotal, carro._velocidadeMaxima*1.1)
		f4.add_point(tempoTotal,  - carro._velocidadeMaxima*1.1)
		divisor = 0
	chart.queue_redraw() # This will force the Chart to be updated

func _on_CheckButton_pressed():
	set_process(not is_processing())
