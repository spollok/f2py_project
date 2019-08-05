import math

import MagTense

def main():
    # Defining grid and positions, angles of magnets
    places = [10, 10, 1]
    area = [1, 1, 0.01]
    filled_positions = [[2, 4, 0], [4, 2, 0], [4, 6, 0], [6, 4, 0]]
    mag_angles = [0, math.pi, math.pi, 0]

    # Standard parameters in settings: max_error=0.00001, max_it=500, iterate_solution=1, return_field=1
    # Optional parameters for setup: param_settings, n_magnets, area, eval_points, eval_mode 
    (tiles, points, grid) = MagTense.setup(places, area, filled_positions=filled_positions, mag_angles=mag_angles)
    (tiles, H) = MagTense.run_simulation(tiles, points, grid=grid, plot=True)

    print(H.get_average_magnetic_flux())

main()
