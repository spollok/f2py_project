import os
import sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)) + '/../lib_mag')
import numpy as np
import math

import MagTense
import MagTenseSource

# Defining grid and positions, angles of magnets
places = [10, 10, 1]
area = [1, 1, 0.01]
filled_positions = [[5, 5, 0]]
mag_angles = [0]

# Standard parameters in settings: max_error=0.00001, max_it=500, iterate_solution=1, return_field=1
# Optional parameters for setup: param_settings, n_magnets, area, eval_points, eval_mode
(tiles, points, grid) = MagTense.setup(places, area, filled_positions=filled_positions, mag_angles=mag_angles)

for tile in tiles:

    H, N = MagTenseSource.fortrantopythonio.getnfromtile( centerpos=tile.center_pos, dev_center=tile.dev_center, \
        rect_size=tile.size, mag=tile.M, u_ea=tile.u_ea, u_oa1=tile.u_oa1, u_oa2=tile.u_oa2, mu_r_ea=tile.mu_r_ea, \
        mu_r_oa=tile.mu_r_oa, mrem=tile.M_rem, tiletype=tile.tile_type, offset=tile.offset, rotangles=tile.rot, \
        color=tile.color, magnettype=tile.magentic_type, statefunctionindex=tile.stfcn_index, includeiniteration=tile.incl_it, \
        exploitsymmetry=tile.use_sym, symmetryops=tile.sym_op, mrel=tile.M_rel, pts=points )

print(H)
print(N)