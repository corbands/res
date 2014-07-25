from django.shortcuts import render

def home(request):
	return render(request, 'res/index.html')

def questions(request):
	return render(request, 'res/questions.html')