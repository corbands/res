from django.conf.urls import patterns, include, url

from django.contrib import admin
admin.autodiscover()

from res import views

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'res.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),

    url(r'^$', views.home, name='home'),
    url(r'^emh/', views.emh, name='emh'),
    url(r'^mp3cutter/', views.mp3c, name='mp3c'),
)
