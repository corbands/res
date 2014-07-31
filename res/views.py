from django.shortcuts import render

def home(request):
	return render(request, 'res/index.html')

def emh(request):
	return render(request, 'res/emh.html')

def mp3c(request):
	return render(request, 'res/mp3c.html')

