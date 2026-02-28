>>> GEOMETRY FILE FOR THE PENELOPE SYSTEM >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

Short description:
  This file contains a simplified version of an SRS cone and phantom.
  Beam travels in -Z DIRECTION. Cone entrance at Z=0, phantom at Z=-90cm.

Last update:
  2008-07-31 by Joel Minj
    Created
  2025-05-30 by Joel Minj
    Modified for -Z beam direction and explicit air hole in the cone.

>>>> END OF HEADER >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


0000000000000000000000000000000000000000000000000000000000000000
SURFACE ( 900)  enclosure:  outermost cylindrical wall
INDICES=( 1, 1, 0, 0,-1)
X-SCALE=(+20.00000000000000E+00,    0)
Y-SCALE=(+20.00000000000000E+00,    0)
0000000000000000000000000000000000000000000000000000000000000000
SURFACE ( 901)  enclosure: NEW TOP plane (near source)
INDICES=( 0, 0, 0, 1, 0)
Z-SHIFT=(+74.40000000000000E+00,    0)  ! Z = +5 cm
0000000000000000000000000000000000000000000000000000000000000000
SURFACE ( 902)  enclosure: NEW BOTTOM plane (far end)
INDICES=( 0, 0, 0, 1, 0)
Z-SHIFT=(-130.0000000000000E+00,    0) ! Z = -150 cm
C
C
C
0000000000000000000000000000000000000000000000000000000000000000
SURFACE ( 502)  backplate: BOTTOM plane
INDICES=( 0, 0, 0, 1, 0)
Z-SHIFT=(+74.00000000000000E+00,    0)
0000000000000000000000000000000000000000000000000000000000000000
BODY    (  50)  backplate
MATERIAL(   4)  W
SURFACE ( 901), SIDE POINTER=(-1)
SURFACE ( 502), SIDE POINTER=(+1)
SURFACE ( 900), SIDE POINTER=(-1)
C
C CONE INNER APERTURE SURFACES (FOR -Z BEAM: Z=0 small entrance to Z=-11 big exit)
C Cone R(Z) = 0.2 - (3/110)*Z. Vertex at Z = +22/3 cm.
C
0000000000000000000000000000000000000000000000000000000000000000
SURFACE (   1)  cone_inner_aperture: lateral wall (implicit form) - NEW DIMENSIONS
INDICES=( 0, 0, 0, 0, 0)
    AXX=(+1.000000000000000E+00,    0)
    AXY=(+0.000000000000000E+00,    0)
    AXZ=(+0.000000000000000E+00,    0)
    AYY=(+1.000000000000000E+00,    0)
    AYZ=(+0.000000000000000E+00,    0)
    AZZ=(-7.438016528925620E-04,    0)
     AX=(+0.000000000000000E+00,    0)
     AY=(+0.000000000000000E+00,    0)
     AZ=(+1.090909090909091E-02,    0)
     A0=(-4.000000000000000E-02,    0)
1111111111111111111111111111111111111111111111111111111111111111
  OMEGA=(+0.000000000000000E+00,    0) DEG
  THETA=(+0.000000000000000E+00,    0) DEG
    PHI=(+0.000000000000000E+00,    0) RAD
X-SHIFT=(+0.000000000000000E+00,    0)
Y-SHIFT=(+0.000000000000000E+00,    0)
Z-SHIFT=(+0.000000000000000E+00,    0)
0000000000000000000000000000000000000000000000000000000000000000
SURFACE (   2)  cone_inner_aperture: SMALLER entrance plane (Z=0, R=0.2cm)
INDICES=( 0, 0, 0, 1, 0)
Z-SHIFT=(+0.000000000000000E+00,    0)
0000000000000000000000000000000000000000000000000000000000000000
SURFACE (   3)  cone_inner_aperture: LARGER exit plane (Z=-11cm, R=0.5cm)
INDICES=( 0, 0, 0, 1, 0)
Z-SHIFT=(-11.00000000000000E+00,    0) ! Cone length 11 cm
C
C CONE OUTER BOUNDARY SURFACE
C Example: Outer cylinder of radius 3cm for cone material.
C This surface is also truncated by Z=0 (SURFACE 2) and Z=-11 (SURFACE 3).
0000000000000000000000000000000000000000000000000000000000000000
SURFACE (   4)  cone_outer_material: cylindrical wall (R=3cm)
INDICES=( 1, 1, 0, 0,-1) ! Canonical Z-cylinder
X-SCALE=(+3.000000000000000E+00,    0)
Y-SCALE=(+3.000000000000000E+00,    0)
C
C PHANTOM SURFACES (Phantom at Z=[-130, -90])
C
0000000000000000000000000000000000000000000000000000000000000000
SURFACE (  15)  phantom: front Z-plane (entrance at Z=-90)
INDICES=( 0, 0, 0, 1, 0) ! Z-planes are consistent
Z-SHIFT=(-90.00000000000000E+00,    0)
0000000000000000000000000000000000000000000000000000000000000000
SURFACE (  16)  phantom: back Z-plane (exit at Z=-130)
INDICES=( 0, 0, 0, 1, 0) ! Z-planes are consistent
Z-SHIFT=(-130.0000000000000E+00,    0)
C
C BODY DEFINITIONS
C Note: Material IDs are assumed: 1=W_alloy, 2=water, 3=air
C
0000000000000000000000000000000000000000000000000000000000000000
BODY    (   4)  cone_air_hole      ! Using your BODY ID (4)
MATERIAL(   3)  air
SURFACE (   1), SIDE POINTER=(-1)  ! Inside NEW FLIPPED inner conical wall
SURFACE (   2), SIDE POINTER=(-1)  ! Z < 0 (NARROW source-facing plane)
SURFACE (   3), SIDE POINTER=(+1)  ! Z > -7.5 (WIDE phantom-facing plane)
SURFACE ( 900), SIDE POINTER=(-1)  ! Within main enclosure R < X/Y-SCALE from SURF 900
SURFACE ( 901), SIDE POINTER=(-1)  ! Z < +0.6 (Your top enclosure plane)
SURFACE ( 902), SIDE POINTER=(+1)  ! Z > -130 (Your bottom enclosure plane for phantom)
0000000000000000000000000000000000000000000000000000000000000000
BODY    (   5)  cone_tungsten_shell ! Using your BODY ID (5)
MATERIAL(   1)  W_alloy95NiFe
SURFACE (   1), SIDE POINTER=(+1)  ! Region *outside* NEW FLIPPED inner conical wall
SURFACE (   4), SIDE POINTER=(-1)  ! Region *inside* outer_material_cylindrical wall (R=3cm)
SURFACE (   2), SIDE POINTER=(-1)  ! and Z < 0
SURFACE (   3), SIDE POINTER=(+1)  ! and Z > -7.5
SURFACE ( 900), SIDE POINTER=(-1)  ! Within main enclosure R < X/Y-SCALE from SURF 900
SURFACE ( 901), SIDE POINTER=(-1)  ! Z < +0.6
SURFACE ( 902), SIDE POINTER=(+1)  ! Z > -130
0000000000000000000000000000000000000000000000000000000000000000
BODY    (   2)  phantom
MATERIAL(   2)  water
SURFACE (  15), SIDE POINTER=(-1)  ! Z < -90 (Region from Z=-90 to Z=-130)
SURFACE (  16), SIDE POINTER=(+1)  ! Z > -130
SURFACE ( 900), SIDE POINTER=(-1)  ! Within main enclosure X,Y (Cyl R=50cm)
SURFACE ( 901), SIDE POINTER=(-1)  ! Z < +10 (Within new top enclosure plane)
SURFACE ( 902), SIDE POINTER=(+1)  ! Z > -150 (Within new bottom enclosure plane)
C
C
C
0000000000000000000000000000000000000000000000000000000000000000
MODULE  (   3)  Simulation Setup (Cone and Phantom in Air)
MATERIAL(   3)  air
SURFACE ( 901), SIDE POINTER=(-1)  ! Z < +10
SURFACE ( 900), SIDE POINTER=(-1)  ! Module bounded by enclosure:
BODY    (  50) 
BODY    (   5)                     ! The tungsten cone shell
BODY    (   4)                     ! The air hole within the cone
BODY    (   2)                     ! The water phantom
SURFACE ( 902), SIDE POINTER=(+1)  ! Z > -150
C Air (Material 3) fills space in module not occupied by BODYs 5, 4, or 2.
0000000000000000000000000000000000000000000000000000000000000000
END
