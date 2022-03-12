'''Script to convert GE format images into a single NIFTI image'''
import argparse
import vtk
from pathlib import Path
from COM.util.volume_rendering import create_iso_surface, add_polydata_to_renderer


def convert_ge_images_to_nifti(
    directory: Path,
    extension: Path,
    image_number: int
):
    path = directory / extension
    image_path = path / Path(f'm_vf{image_number}.' + str(extension))

    reader = vtk.vtkGESignaReader()
    reader.SetFileName(str(image_path))

    surface = create_iso_surface()


def main():
    description = '''Convert directory of GE format images to single NIFTI
    image'''
    parser = argparse.ArgumentParser(
        formatter_class=argparse.RawTextHelpFormatter,
        prog='Convert GE to NIFTI',
        description=description
    )
    parser.add_argument('directory', type=Path)
    parser.add_argument('extension', type=Path)
    parser.add_argument('image_number', type=int)

    args = parser.parse_args()

    convert_ge_images_to_nifti(**vars(args))


if __name__ == '__main__':
    main()
