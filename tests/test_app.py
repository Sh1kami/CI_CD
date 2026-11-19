import unittest
from app import greeting

class GreetingTests(unittest.TestCase):
    def test_normal(self):
        self.assertEqual(greeting('Богдан', 20), 'Привіт Богдан, через рік тобі буде 21 років!')
    def test_zero(self):
        self.assertIn('1 років!', greeting('Богдан', 0))
    def test_empty_name(self):
        with self.assertRaises(ValueError): greeting(' ', 20)
    def test_negative(self):
        with self.assertRaises(ValueError): greeting('Богдан', -1)
    def test_type(self):
        with self.assertRaises(ValueError): greeting('Богдан', '20')
    def test_bool(self):
        with self.assertRaises(ValueError): greeting('Богдан', True)
    def test_upper_bound(self):
        with self.assertRaises(ValueError): greeting('Богдан', 151)
