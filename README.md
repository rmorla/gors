# gors

The gors setup relies on virtual machines that run locally on the target infrastructure. 

We use a proxmox virtualization cluster with multi-NIC hosts for physical connection with physical network and network hardware. Each NIC is bond to a virtual bridge, which in turn allows each VM to access each physical network.

The Configuration VM connects to the Target VMs where you're going to deploy the components (network, services, applications, and management services) you want to be running. The Config VM also serves as default gateway for provisioning the Target VMs. The Config VM does not run any of the components you want to deploy.

Note: the default gateway for the deployed network is part of the deployed components; ideally it should not be the Config VM because the deployed components should run without the Config VM. 

[Diagram of the reference physical setup](physical-setup.pdf)


## Configuration VM and management network

The configuration VM must run any configuration and infrastructure-as-code software that is required for the deployment.

The configuration VM has two  network interfaces:
- One interface that connects to the public network ; this allows the deployment user to connect to the VM, and to provide Internet connection for the target VMs
- One interface that connects to the management network ; this network allows the configuration VM to provision the target VMs, but can also be used for the network management services 

## Target VMs

The Target VMs is where your services are going to be deployed. You need to save a clean snapshot that you can bring back before starting deployment. We assume the target VM is an ubuntu box with user gors.

## Connecting to other hardware 

We want to be able to connect our virtual setups with physical equipment like switches, routers, firewalls, etc. To do so we can use the macvlan type of network in docker. This type of network can be bound to a physical ethernet interface on the host. The docker containers that are connected to this macvlan network can access the physical devices that are connected to the other end of the ethernet interface. For example, we can have a DHCP server running in a container and serving IP addresses to PCs and other hardware.

# setup

## keys

add a gors-target entry to your .ssh/config file with access to the target vm 

https://www.digitalocean.com/community/tutorials/how-to-configure-custom-connection-options-for-your-ssh-client

## IP addresses

We use 192.168.88.0/24 as the management network. The IP of the configuration VM on the management network is 192.168.88.100 (on eth1). We assume the configuration VM has another interface (eth0) which is the default gateway for the VM. If the target VM is on 192.168.88.101, then we configure the default gateway on the target VM as 192.168.88.100 and setup IP forwarding and NAT on the Configuration VM as follows :

Config VM:
- sysctl -w net.ipv4.ip_forward=1
- iptables -t nat -A POSTROUTING -s 192.168.88.101 -o eth0 -j MASQUERADE

Target VM:
- ip r a default via 192.168.88.100 




