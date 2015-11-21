#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import print_function, division
import numpy as np
import struct


class Tensor(object):
    def __init__(self):
        self.name = None
        self.value = None
        

CODE_TO_TYPE = {
    0: np.float16,
    1: np.float32,
    2: np.float64,
    3: np.uint8,
    4: np.uint16,
    5: np.uint32,
    6: np.uint64,
    7: np.int8,
    8: np.int16,
    9: np.int32,
    10: np.int64,
    11: np.dtype('a').type,
    12: np.dtype('b').type
}

TYPE_TO_CODE = {
    np.float16: 0,
    np.float32: 1,
    np.float64: 2,
    np.uint8: 3,
    np.uint16: 4,
    np.uint32: 5,
    np.uint64: 6,
    np.int8: 7,
    np.int16: 8,
    np.int32: 9,
    np.int64: 10,
    np.dtype('a').type: 11,
    np.dtype('b').type: 12
}


def code2type(code):
    try:
        return CODE_TO_TYPE[code]
    except KeyError:
        raise ValueError('Unknown type code {}'.format(code))


def type2code(t):
    try:
        return TYPE_TO_CODE[t]
    except KeyError:
        raise TypeError('Unknown tensor type {}'.format(t))


def read_tensor(filename):
    tensors = []
    with open(filename, 'rb') as fp:
        type_code_str = fp.read(1)
        while len(type_code_str) > 0:
            tensor = Tensor()
            type_code = np.fromstring(type_code_str, dtype=np.uint8)[0]
            tensor_type = code2type(type_code)
            fp.read(4)  # type size
            name_length = struct.unpack('i', fp.read(4))[0]
            tensor.name = fp.read(name_length).decode('ascii')
            num_dims = struct.unpack('i', fp.read(4))[0]
            # maybe zero padding at the end of a feature file
            if num_dims == 0:
                break
            dims = np.fromstring(fp.read(4 * num_dims), dtype=np.int32)
            num_bytes = np.prod(dims) * 4
            tensor.value = np.fromstring(
                fp.read(num_bytes), dtype=tensor_type).reshape(dims)
            tensors.append(tensor)
            type_code_str = fp.read(1)
    return tensors


def read_tensor_v0(filename):
    tensors = []
    with open(filename, 'rb') as fp:
        name_length_str = fp.read(4)
        while len(name_length_str) > 0:
            tensor = Tensor()
            tensor_type = np.float32
            name_length = struct.unpack('i', name_length_str)[0]
            tensor.name = fp.read(name_length).decode('ascii')
            num_dims = struct.unpack('i', fp.read(4))[0]
            # maybe zero padding at the end of a feature file
            if num_dims == 0:
                break
            dims = np.fromstring(fp.read(4 * num_dims), dtype=np.int32)
            num_bytes = np.prod(dims) * 4
            tensor.value = np.fromstring(
                fp.read(num_bytes), dtype=tensor_type).reshape(dims)
            tensors.append(tensor)
            name_length_str = fp.read(4)
    return tensors


def write_tensor(filename, tensors):
    with open(filename, 'wb') as fp:
        for tensor in tensors:
            fp.write(np.array(type2code(tensor.value.dtype.type),
                              dtype=np.uint8).tostring())
            fp.write(np.array(tensor.value.dtype.itemsize,
                              dtype=np.uint32).tostring())
            fp.write(struct.pack('i', len(tensor.name)))
            fp.write(tensor.name)
            fp.write(struct.pack('i', len(tensor.value.shape)))
            fp.write(np.array(tensor.value.shape, dtype=np.int32).tostring())
            fp.write(tensor.value.tostring())
