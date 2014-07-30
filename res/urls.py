from django.conf.urls import patterns, include, url

from django.contrib import admin
admin.autodiscover()

from res import views

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'res.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),

    url(r'^', 'res.views.home', name='home'),
    url(r'^questions/', 'res.views.questions', name='questions'),
    url(r'^admin/', include(admin.site.urls)),
)
