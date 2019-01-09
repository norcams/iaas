==================
Nettverksproblemer
==================

Hvis det dukker opp nettverksproblemer under oppretting av nye instanaser,
pleier disse stegene å hjelpe:

- Restarte neutron-server og etcd på Network
- Kjøre ansible playbook "restart_compute_services.yaml" på Compute

