# Monte Carlo Simulation of SRS Dosimetry
## 240NU215 - Monte Carlo Simulation of Radiation Transport - Project

This simulation models the radiation transport of a clinical Stereotactic Radiosurgery (SRS) setup. It is executed using the **PENELOPE (PENetration and Energy LOSS of Positrons and Electrons)** [https://doi.org/10.1016/0168-583X(95)00349-5] v.2018 code system, operated via the `penEasy` (v.2024-03-13) main program. 


<p align="center">
  <img src="https://github.com/user-attachments/assets/49fe62e1-387d-40da-81f6-b740b3d1c5cf" width="45%" />
  <img src="https://github.com/user-attachments/assets/8fc9a7a3-da74-48a6-962b-50dafb8d6ae0" width="45%" />
</p>



### 1. Physical Transport Model
The Monte Carlo engine employs a "Class II" mixed simulation algorithm for the transport of electrons and positrons. 


In this framework, interactions are divided into two categories based on predefined energy cutoffs ($W_{CC}$ and $W_{CR}$):
* **Hard Collisions:** Interactions involving large energy losses or angular deflections (e.g., catastrophic bremsstrahlung, Moeller/Bhabha scattering) are simulated event-by-event.
* **Soft Collisions:** Interactions with small energy transfers are aggregated and described using a condensed history approach based on the continuous-slowing-down approximation (CSDA) and multiple scattering theories.

For the $6.0 \text{ MeV}$ photon transport, the code simulates four primary interaction mechanisms event-by-event: Rayleigh (coherent) scattering, Photoelectric absorption, Compton (incoherent) scattering, and $e^-/e^+$ Pair Production.

### 2. Geometry and Material Specifications
The geometry is constructed using PENELOPE's constructive quadric geometry package (`PENGEOM`), defining a simplified SRS conical collimator and a downstream water phantom.


<p align="center">
  <img src="https://github.com/user-attachments/assets/3dcef663-998a-4e1f-8ca8-e7fba05c2737" width="45%" />
  <img src="https://github.com/user-attachments/assets/a845bd32-7a01-488e-8144-7c755ba2a5f2" width="45%" />
</p>



* **Phantom:** A homogenous water equivalent volume ($\rho = 0.998 \text{ g/cm}^3$, Material 2) positioned from $Z = -90 \text{ cm}$ to $Z = -130 \text{ cm}$.
* **SRS Cone:** Modeled as a truncated quadric cone comprised of a Tungsten-Nickel-Iron alloy (W-alloy95NiFe, $\rho = 18.3 \text{ g/cm}^3$, Material 1).
* **Backplate:** Solid Tungsten ($\rho = 19.3 \text{ g/cm}^3$, Material 4) located near the source.

### 3. Source Characterization
The incident beam is modeled using the `penEasy` Box Isotropic Gauss Spectrum (BIGS) source:
* **Particle:** Monoenergetic Photons ($\gamma$).
* **Energy:** $6.0 \text{ MeV}$.
* **Position:** $Z = 74.0 \text{ cm}$ (Entrance of the collimation system).
* **Direction:** The beam is strictly directed along the negative Z-axis: $\vec{d} = (u, v, w) = (0, 0, -1)$.

### 4. Dosimetric Scoring (Tallies)
The primary dosimetric quantity, the Absorbed Dose ($D$), is calculated as the expectation value of the energy imparted ($\epsilon$) per unit mass ($m$) within designated voxels:

$$D = \frac{d\bar{\epsilon}}{dm} \approx \frac{1}{\rho \Delta V} \sum_{i=1}^{N_{int}} \Delta E_i$$

Where $\Delta E_i$ represents the energy deposited during the $i$-th interaction in a voxel of volume $\Delta V$. 



Two primary tallies were active:
1. **Spatial Dose Distribution (SDD):** Scoring in the Cartesian grid spanning the phantom depth $Z \in [-130, -90] \text{ cm}$ partitioned into 300 bins.
2. **Cylindrical Dose Distribution (CDD):** Capturing the radial dose profile with 50 radial bins ($R \in [0, 10] \text{ cm}$) and 50 depth bins ($Z \in [-100, -90] \text{ cm}$).

### 5. Transport Parameters and Convergence
To balance dosimetric precision against computational cost, absorption energies ($E_{abs}$) were aggressively tuned. Particles falling below these thresholds deposit their remaining kinetic energy locally:

| Material | Description | $E_{abs}(e^-)$ [keV] | $E_{abs}(\gamma)$ [keV] | $E_{abs}(e^+)$ [keV] |
| :--- | :--- | :--- | :--- | :--- |
| **1** | W-Alloy (Cone) | 500.0 | 100.0 | 500.0 |
| **2** | Water (Phantom)| 60.0 | 6.0 | 10.0 |
| **3** | Air | 100.0 | 10.0 | 100.0 |

**Statistical Variance:**
The simulation processed $N = 1.0 \times 10^7$ primary histories. According to the Central Limit Theorem, the relative statistical uncertainty $\eta$ of the Monte Carlo estimator scales as:

$$\eta \propto \frac{1}{\sqrt{N}}$$



The requested relative uncertainty threshold was set to $1.0\%$. The post-simulation log indicates this target was *not* reached within the allotted $10^7$ histories. Because Variance Reduction Techniques (VRTs) such as Interaction Forcing or Particle Splitting were entirely disabled (`OFF`), future optimization will require either an order-of-magnitude increase in $N$ or the implementation of geometric splitting within the collimator aperture.
