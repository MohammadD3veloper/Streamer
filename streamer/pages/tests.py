from django.test import TestCase


# Create your tests here.
class PagesViewsTest(TestCase):
    """ Test pages application views """

    def test_index(self):
        """ test index view """

        response = self.client.get('/')
        assert response.status_code == 200
