import sys
from distutils.core import setup

if sys.version_info < (3, 5):
    raise NotImplementedError("Sorry only Python 3.5+ is supported")

setup(
    name='rediris',
    packages=['rediris'],
    version='0.1',
    description='Pure Python Redis server implementation with InterSystems IRIS as a persistence engine.',
    license='MIT',
    author='eduard93',
    url='https://github.com/eduard93/rediris',
    keywords=['redis', 'server','intersytems'],
    install_requires=[
        'lupa',
    ],
    classifiers=[
        'Development Status :: 4 - Beta',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: MIT License',
        'Operating System :: OS Independent',
        'Programming Language :: Python :: 3',
    ]
)