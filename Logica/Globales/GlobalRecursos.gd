extends Node

# Singleton para manejar el dinero y los minerales actuales

# inicia en ceros
var minerales : Array = [0,0,0,0,0,0,0,0,0,0,0]
var dinero : int = 0
signal cambioDinero(dinero)
signal cambioMineral(mineral, cantidad)
# enum para no perderlos de vista

enum mineralesSinFondo{
	Hierro,
	Plata,
	Oro,
	Carbon,
	Cobre,
	Amatista,
	Esmeralda,
	Topacio,
	Rubi,
	Zafiro,
	Diamante,
}

enum mineralesConFondo{
	Hierro,
	Plata,
	Oro,
	Carbon,
	Cobre,
	Amatista,
	Tierra,
	TierraMinada,
	Topacio,
	Rubi,
	Zafiro,
	Diamante,
	Esmeralda
}

func _ready() -> void:
	GlobalTiempo.finalizarDia.connect(pagueme_la_renta)

func actualizar_mineral(mineral : int, cantidad : int):
	minerales[mineral] += cantidad
	cambioMineral.emit(mineral, minerales[mineral])

func actualizar_dinero(cantidad : int):
	dinero += cantidad
	if dinero < 0:
		#todo gameover por bancarota
		print('geim ouver')
		pass
	cambioDinero.emit(dinero)

func pagueme_la_renta():
	var valorDia = 5*GlobalTiempo.diaActual
	if valorDia > 50:
		valorDia = 50
	actualizar_dinero(-10 - valorDia)
