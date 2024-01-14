from django.views import generic


# Create your views here.
class IndexPage(generic.TemplateView):
    template_name = "index.html"
