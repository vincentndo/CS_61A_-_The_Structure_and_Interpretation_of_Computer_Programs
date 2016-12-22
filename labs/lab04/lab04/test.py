def multiadder(n):

	assert n > 0

	if n == 1:
		return lambda x: x
	else:
		return lambda x: multiadder(n - 1) + x