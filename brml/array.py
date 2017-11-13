import numpy as np


class table(object):
    """
    Abstract base class for a table with matlab like interface.
    To be implemented with np.ndarray
    """

    def ndim(self):
        pass

    def T(self): # transpose
        raise NotImplementedError


class array(object):
    def __init__(self, variables=None, table=None):
        self._variables = self.variables.setter(variables)
        self._table = self.table.setter(table)

    @property.setter
    def variables(self, vars):
        if vars is not None:
            assert all(isinstance(v, int) for v in vars)
            self._variables = vars

    @property.getter
    def variables(self):
        return self._variables

    @property.setter
    def table(self, value):
        if value is not None:
            assert value.ndim == len(self.variables)
            return value

    @property.getter
    def table(self):
        return self._table

    def to_log_array():
        pass

    @property
    def size(self):
        raise NotImplementedError

def sumpot(pot, variables):
    newpot = array()
    newpot.variables = list(set(pot.variables) - set(variables))
    # indices of the table that will be summed over
    table_variables = [idx for idx in pot.variables if idx in variables]
    # s = size(pot.table);
    # if length(size(pot)) == 1 & & s(1) == 1 % if there is only one variable it might be stored as a row vector
    #     t = pot.table'; % flip to make row vector
    # else
    #     t = pot.table; % get the table array end
    s = pot.table.shape
    if len(pot.size) == 1 and s[0] == 1:
        t = pot.table.T
