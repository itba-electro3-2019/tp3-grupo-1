""" Cuts an oscilloscope's image. Returns the same image withouth the bottom label.
	[Usage]
		python cut_osc_image.py input_image
"""

# importing modules
from PIL import Image

import sys


def get_kwargs_default(key, default, **kwargs):
	if key in kwargs.keys():
		return kwargs[key]
	else:
		return default


def crop_image(filepath: str, **kwargs):
	""" Returns the given image cutting the bottom part
		[kwargs]
			+ left, top, right, bottom cutting width
	"""
	image_object = Image.open(filepath)
	return image_object.crop(
		(
			get_kwargs_default("left", 0, **kwargs),
			get_kwargs_default("top", 0, **kwargs),
			image_object.size[0] - get_kwargs_default("right", 0, **kwargs),
			image_object.size[1] - get_kwargs_default("bottom", 0, **kwargs)
		)
	)


def get_path_from_filepath(filepath: str):
	""" Returns the path of the filepath
	""" 
	return "/".join(filepath.split("/")[:-1])


def get_filename_from_filepath(filepath: str):
	""" Returns the filename of the filepath
	"""
	return filepath.split("/")[-1]


def normalize_spaces(*args):
	""" If one filepath is expected but spaces are being used...
	"""
	return " ".join(args)


def normalize_slashes(filepath: str):
	""" Normalizes slashes in the given filepath
	"""
	return filepath.replace("\\", "/") if "\\" in filepath else filepath


if __name__ == "__main__":
	try:
		filepath = normalize_slashes(normalize_spaces(*sys.argv[1:]))
		new_image = crop_image(filepath, top=54, bottom=65) # Metele 65 cuando es con Cursores!
		new_image.save("{}cropped_{}".format("{}/".format(get_path_from_filepath(filepath)) if "/" in filepath else "", get_filename_from_filepath(filepath)))
	except Exception as exception:
		print(
			""" An exception has occurred! Something went wrong, read the script documentation please.
			Exception: {}
			""".format(exception)
		)
