import unittest
# import extra modules

class TestBeam(unittest.TestCase):

    def setUp():
        # setup the objects/parameters you want to test
        pass

    def tearDown():
        pass

    ## test suite one

    def test_one():
        # test case functions must start with test_
        pass

    def test_two():
        pass

    def suite():
        tests = ['test_one', 'test_two']
        return unittest.TestSuite(map(TestBeam, tests))

# running the module from the commandline will make the unittests interactive
if __name__ == '__main__':
    unittest.main()
