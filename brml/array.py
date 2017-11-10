import numpy as np


class table(object):
    """
    Abstract base class for a table with matlab like interface.
    To be implemented with np.ndarray
    """

    def ndim(self):
        pass


class array(object):
    def __init__(variables=None, table=None):
        self._variables = self.variables(variables)
        self._table = self.table(table)

    @property.setter
    def variables(self, vars):
        if vars is not None:
            assert all(isinstance(v, int) for v in vars)
            self._variables = vars

    @property
    def variables(self):
        return self._variables

    @property.setter
    def table(self, value):
        if value is not None:
            assert value.ndim == len(self.variables)
            return value

    @property
    def table(self):
        return self._table

    def to_log_array():
        pass


def sumpot(pot, variables):
    newpot = array()
    newpot.variables =