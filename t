[33mcommit b17fda5ee3ca5d3d656440cb0cd13b70fa7ac020[m[33m ([m[1;36mHEAD -> [m[1;32mapplication-gateway[m[33m, [m[1;31morigin/application-gateway[m[33m)[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 19 18:52:19 2022 -0300

    feat: Provisiong AKS + Application Gateway

[33mcommit b32dc7a3b1e49f8bd378780d725c6277a05a1a27[m[33m ([m[1;31morigin/main[m[33m, [m[1;31morigin/HEAD[m[33m, [m[1;32mmain[m[33m)[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 19 03:34:12 2022 -0300

    feat(install/): Configure ArgoCD TLS Certificate with Azure Application Gateway

[33mcommit 5f397a3910b2f98786c751e40d8980df1e98a464[m[33m ([m[1;33mtag: 0.7.0[m[33m)[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Fri Mar 18 19:43:54 2022 -0300

    bump: version 0.6.0 → 0.7.0

[33mcommit 058ca7a88c86414b1b71bd16b11d9342c7b5a640[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Fri Mar 18 18:32:34 2022 -0300

    refactor(foundation/): Base image for AKS Cluster

[33mcommit da444c24c3fa36afc381bbf5785cb04865b58e55[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Thu Mar 17 20:59:59 2022 -0300

    refactor(install/application-gateway-ingress-controller/install-with-managed-identity-stack.sh): Loop to wait for Ingress LoadBalancer Public IP

[33mcommit 1588b1d02d9b22bfe68a5252dbce40f81cdbc4c5[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Thu Mar 17 20:26:00 2022 -0300

    fix(install/application-gateway-ingress-controller/): Add armAuth.type=aadPodIdentity

[33mcommit 065a31d4c809c19a9828c89cede2a3484981e6a7[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Thu Mar 17 18:21:28 2022 -0300

    feat(install/application-gateway-ingress-controller/*.sh): Mode update to +x

[33mcommit 1015673790c4e5f6cf60543c636ad71c1e7c239b[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Thu Mar 17 08:29:32 2022 -0300

    feat(install/application-gateway-ingress-controller/install-with-managed-identity.sh): Update Install Script

[33mcommit 2edbdf905258c3b11c1e919ec8665c7282f37e3e[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Wed Mar 16 09:24:14 2022 -0300

    feat: Install AGIC with Managed Identity

[33mcommit e3ff4b07b0db2ca2ce47bacf7f35a0ed44f05b2e[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Wed Mar 16 07:47:12 2022 -0300

    feat(foundation/aks-cluster/docker/build): Update AKS Base Image to 3.10.1

[33mcommit aa950e775bb59fa288b6df66ab08a9546e79d241[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Wed Mar 16 07:30:15 2022 -0300

    feat: Install AGIC with Service Principal

[33mcommit 2c28921c845feb2af8309b4f2e9c002a437953aa[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Tue Mar 15 07:53:01 2022 -0300

    refactor: Common Parameters Set

[33mcommit 241591e2e37d319eabe797ed77f2523d37676ee5[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Mon Mar 14 17:19:13 2022 -0300

    refactor: AKS Image Parameter

[33mcommit f29e591a0a092432044039d1113d26411c043600[m[33m ([m[1;33mtag: 0.6.0[m[33m)[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Mon Mar 14 16:02:03 2022 -0300

    bump: version 0.5.0 → 0.6.0

[33mcommit 22693ae0f6fd263c09421d7c5ede3eda654d601f[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Mon Mar 14 14:51:40 2022 -0300

    feat(foundation/aks-cluster/): Update Stack image version

[33mcommit f36a44dc985de7e0546b53623e47b54c17a2efdd[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Mon Mar 14 13:51:33 2022 -0300

    fix: Update ArgoCD CNAME

[33mcommit 46ac22d8b990ad496eaf11a922a026645c691572[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Mon Mar 14 13:22:30 2022 -0300

    refactor(pipelines/): Change Installation order

[33mcommit 9416b149a69c795d3c45628b6f88d490dccdadc0[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Mon Mar 14 13:04:58 2022 -0300

    feat(install/argocd/install.sh): Change CNAME record

[33mcommit ac1f3bb0c9e9247afbc8357b68e6c2f698d5f634[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Mon Mar 14 13:01:16 2022 -0300

    feat(install/httpbin): New script to install httpbin

[33mcommit 184f563a1e9166262f29382a33f97a0999fe0a49[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Mon Mar 14 09:58:26 2022 -0300

    refactor(install/external-dns/): Use External Secrets to retrieve Azure Credentials

[33mcommit 89432cded2888c1f0273f26769344f6f332dc90e[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Mon Mar 14 08:36:14 2022 -0300

    refactor: Foundation run.sh script

[33mcommit 8e1b52170cc5a7531c69177ef0ba7923ab58bc03[m[33m ([m[1;33mtag: 0.5.0[m[33m)[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Mon Mar 14 08:19:18 2022 -0300

    bump: version 0.4.0 → 0.5.0

[33mcommit 2b463c5600bb075a0096d4958c97b11dcb3ca76d[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Mon Mar 14 08:19:11 2022 -0300

    feat: Update foundation scripts

[33mcommit 8e2fb21e9652892e27f089df6667d40d0dde9e05[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Mon Mar 14 08:18:31 2022 -0300

    refactor(foundation/aks-cluster/docker/build): Remove intermediate containers after build

[33mcommit de910771f092b0117b80584b83b718ab27a47975[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Mon Mar 14 07:45:00 2022 -0300

    refactor(pipelines): Add comments to show Parameters

[33mcommit 5c849279d1081fa6b16ef6a54e045385a923568f[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Mon Mar 14 07:22:16 2022 -0300

    refactor(install/cert-manager/cluster-issuers.yaml): Indent yaml

[33mcommit 97919b920ef1678358962806be22ce75c147ba2f[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sun Mar 13 21:06:22 2022 -0300

    refactor(install/external-dns/install.sh): Add Helm --wait

[33mcommit 7c7ddb0be559cc86f73b1e6fd7d25d4476189b76[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sun Mar 13 20:51:15 2022 -0300

    feat(install/argocd): Enable Lets Encrypt ArgoCD Certificate

[33mcommit a28d8be64732a9c3f63c093d54927250993fc3a7[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sun Mar 13 20:23:27 2022 -0300

    feat(pipelines): Add steps to install cert-manager and external-secrets

[33mcommit 791aad0e30c0c09cd91dfeaeee363eea3f70c827[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sun Mar 13 20:09:33 2022 -0300

    feat(install/argocd/): Configure ArgoCD AzureAD SSO

[33mcommit 1cbdba4b5989a29f047ee2e730d5da73b2733df6[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sun Mar 13 19:10:42 2022 -0300

    feat(install/cert-manager/install.sh): Install cert-manager

[33mcommit 64d68d94113c20169a2ba7c64dda20aa9e27943f[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sun Mar 13 19:02:44 2022 -0300

    feat(install/external-secrets/install.sh): Install external-secrets

[33mcommit 51e88e5ec5b5f3663a7ced0b632d5b6a955f2bde[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sun Mar 13 12:18:47 2022 -0300

    feat(install/argocd/install.sh): Add Azure SSO Config

[33mcommit f247534810e1742b6e232c390d829a0d775cf189[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sun Mar 13 11:17:14 2022 -0300

    refactor(install/argocd/install.sh): Update to use latest version

[33mcommit 87bb3298c99d92778886f5bf6a7707f3e3416269[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sun Mar 13 11:06:21 2022 -0300

    refactor(install/argocd/install.sh): Remove wait with for and use only Helm --wait

[33mcommit 6cadfd2f12dac7c09e6de7d368f714aaf15d1785[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sun Mar 13 11:05:09 2022 -0300

    refactor(install/external-dns/install.sh): Remove comments

[33mcommit efe9078020b8bde3ce3106499c0d3aa9f435dcbe[m[33m ([m[1;33mtag: 0.4.0[m[33m)[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sun Mar 13 10:40:24 2022 -0300

    bump: version 0.3.0 → 0.4.0

[33mcommit c88295dc4106f6ca67a491d24e7556732442dbb4[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sun Mar 13 10:40:19 2022 -0300

    refactor(pipelines/common/steps/install-terraform-packager.yaml): Step terraform-packager rename Display Name

[33mcommit c1aa43348c49646970ede992a06a5e022ffd7916[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sun Mar 13 10:35:04 2022 -0300

    fix(pipelines/common/steps/provision-kubernetes-cluster.yaml): Add -auto-approve to apply

[33mcommit ae1c7b6774dbc404895c597fe871f75025f99a43[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sun Mar 13 10:32:04 2022 -0300

    fix(pipelines/common/steps/provision-kubernetes-cluster.yaml): Remove environment parameter reference

[33mcommit ba34f9419085f9a30d8fd3ec8ab298931f532c25[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sun Mar 13 10:30:35 2022 -0300

    feat(pipelines/common/steps/provision*): Refactor to use apply again

[33mcommit 9715be6abdba24f0521ccbd664de0cf2957380cb[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sun Mar 13 10:23:47 2022 -0300

    feat(foundation/aks-cluster/docker/Dockerfile.template): Set STACK_INSTANCE_NAME as immutable

[33mcommit 16160b5aafe21ba0da2589afcb7f6c87bf733466[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 12 22:26:01 2022 -0300

    refactor(pipelines): Provision Environment with Parameter

[33mcommit 76b880caaae043f4fc108df07622f54d76e92a78[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 12 22:07:07 2022 -0300

    feat(pipelines): Refactor to extract common/steps/provision-environment.yaml

[33mcommit 75b1e8e4d4e39f9872a69e0355f497e6dce8f382[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 12 22:05:08 2022 -0300

    refactor(common/steps/): Update steps displayName

[33mcommit a139214d8f66e449e79350d2cc84de1cb155f288[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 12 22:02:49 2022 -0300

    feat(pipelines): Refactor to extract common/steps/install-external-dns.yaml

[33mcommit ad72a0e45967522d1ffb5256312ca54ac6b496e8[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 12 21:58:47 2022 -0300

    feat(pipelines): Refactor to extract common/steps/install-kubernetes-cluster.yaml

[33mcommit 5259d9b1a79580a0136c622684758152ec1ba4a9[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 12 21:55:52 2022 -0300

    feat(pipelines): Refactor to extract common/steps/install-nginx-ingress-controller.yaml

[33mcommit 8b6be4f10aeed5f4bc49d6f10f55124f4a8e725a[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 12 21:54:09 2022 -0300

    refactor(common/steps/): Update steps displayName

[33mcommit 2a3cc72cffab4df4fb7ac0a2a5d26e42d0f8703a[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 12 21:52:13 2022 -0300

    refactor(pipelines): Refactor to extract common/steps/install-argocd.yaml

[33mcommit 3cc279ec0894481d420b76a3bdbeb5143388f5c2[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 12 21:49:03 2022 -0300

    feat(pipelines): Refactor to extract common/steps/install-kubectl.yaml

[33mcommit 510610fab16f52703879f040ee2d6fb1297f0976[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 12 21:44:49 2022 -0300

    feat(pipelines): Refactor to extract common/steps/install-argocd.yaml

[33mcommit 8b2b6e300abec848e103bb9877d48a7e03d6d8b8[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 12 21:42:05 2022 -0300

    feat(pipelines): Refactor to extract common/steps/install-httpbin.yaml

[33mcommit 9a0d59dd9bd5f5ba3c6e2742120c6cf914c06e02[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 12 21:39:27 2022 -0300

    feat(pipelines): Refactor to extract common/steps/install-helm.yaml

[33mcommit 54f7827b2124760952e4e976175358533ee4d45c[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 12 21:32:23 2022 -0300

    feat(pipelines): Refactor to extract common/steps/install-terraform-packager.yaml

[33mcommit 73fec26f99918bc96a8da615d7db14912e96817c[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 12 21:17:41 2022 -0300

    feat(pipelines/foundation.yaml): Install ArgoCD

[33mcommit 39732b33ce7ba5f3e7a6ebeb4d207356bf557aef[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 12 21:04:56 2022 -0300

    feat(pipelines/foundation.yaml): Install httpbin Helm Chart

[33mcommit 15999b48c6d50ebfcec745eb1d22094d705582f6[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 12 20:00:16 2022 -0300

    feat(pipelines/foundation.yaml): Install ExternalDNS

[33mcommit 8d16743479142b0f9ab9a828af9a445c40183056[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 12 19:51:00 2022 -0300

    fix(pipelines/foundation.yaml): AKS Get Credentials

[33mcommit cfaaf841d3259ab8d06ebb0765b7367d8061e1ab[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 12 18:14:19 2022 -0300

    feat(pipelines/foundation.yaml): Install NGINX Ingress Controller

[33mcommit e41ce8137d688f1c2b4d864155bea22d614c0261[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 12 17:03:33 2022 -0300

    feat(pipelines): Update Foundation Pipeline

[33mcommit 518a1e4622dc25b163e11e5281990e5ac64393b2[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 12 09:36:14 2022 -0300

    feat(pipelines): Foundation

[33mcommit 19b4dafa8f3ad6cb9f445bc5077e6df85c0b9bed[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Fri Mar 11 09:24:22 2022 -0300

    feat(run.sh): External DNS commands

[33mcommit 15a712803ce58f13a953dab627b04d6a435e457d[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Fri Mar 11 09:02:23 2022 -0300

    refactor(httpbin/raw): Remove Directory

[33mcommit bb8cfd9495efdde8205044a08ede8aad56e76673[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Fri Mar 11 08:37:16 2022 -0300

    feat(charts): Add httpbin Helm Chart with Ingress

[33mcommit 2b6f15fbed51dc1a6d06f10e40a6a68ad614a2c6[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Thu Mar 10 20:30:03 2022 -0300

    feat(foundation/): Add an AKS Cluster

[33mcommit 1feff59dd871422f2b1b1b0b28ea1a15e355da3f[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Thu Mar 10 20:08:05 2022 -0300

    feat(foundation/): Create directory with scripts to generate an new environment

[33mcommit 738576ef2a1ab6023530675aedc88337662c5936[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Tue Mar 8 08:31:40 2022 -0300

    feat(install/): ArgoCD Install using Helm

[33mcommit 40ff7f44e32ba72ed4978ee57d9dfd68eaaed9c7[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Tue Mar 8 07:45:40 2022 -0300

    feat(root): Customize ArgoCD Namespace

[33mcommit 02e008ec05457aa8e473ebc1af88b032deca7cbf[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Mon Mar 7 20:15:00 2022 -0300

    feat(infrastructure/): Rename values files and update parameters

[33mcommit 988ec29e6023ee8eb250205185a715bcd4d55eba[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Mon Mar 7 19:51:23 2022 -0300

    feat(infrastructure/argocd-application.yaml): Remove file

[33mcommit db8f5f266e47384ba4190f8d9e726baa1c796aa9[m[33m ([m[1;33mtag: 0.3.0[m[33m)[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sun Mar 6 23:03:03 2022 -0300

    bump: version 0.2.0 → 0.3.0

[33mcommit 6a84ca87d0f1f31ff092cd7366b5ed4684921c80[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sun Mar 6 22:40:18 2022 -0300

    feat(infrastructure/): Install istio-gateway on Kind Cluster

[33mcommit 6a71f8e9db0d25c1877cf3aed321c2a83a208891[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sun Mar 6 22:23:27 2022 -0300

    feat(infrastructure/): Install istio on kind cluster

[33mcommit 58d2954ab8e422b1faf191990abd1015001b3170[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sun Mar 6 22:04:55 2022 -0300

    feature(infrastructure/): Customize helm files for app-of-apps ArgoCD App

[33mcommit 12d6bb216adc2de7996fb53ffc29f5ff69e83e7b[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sun Mar 6 21:50:06 2022 -0300

    feature(nfrastructure/charts/istio-gateway/): Create istio-gateway Helm Chart

[33mcommit 591c63347698be72fba3d202d0629614d65e9842[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sun Mar 6 21:42:53 2022 -0300

    refactor(infrastructure/charts/): Rename istio to istio-istiod Helm Chart

[33mcommit afd731871cebe45865cc353fd31d8797d87cccb8[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sun Mar 6 20:54:24 2022 -0300

    feat(infrastructure/): Create cert-manager Helm Chart

[33mcommit 058bb74bd380e996cff101c2a698591cd092d5d7[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sun Mar 6 20:46:19 2022 -0300

    feat(kustomize/example/helm-example/): Remove helm-example Helm Chart

[33mcommit c3d845ce9f03cc42eb22c346e5c4b50bdda86a86[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sun Mar 6 20:16:20 2022 -0300

    refactor(infrastructure/bootstrap/app-of-apps/): Rename files and update values

[33mcommit 00af2ba55ce2035b8ff2b4a094aa7d720dd41c4e[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sun Mar 6 12:03:39 2022 -0300

    refactor(scripts): Rename values and scripts

[33mcommit e6686eb27cb714e47e42f0178959e02927d224bb[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sun Mar 6 11:17:33 2022 -0300

    feat(infrastructure/): Split infra ArgoCD Project from app-of-apps Helm Chart

[33mcommit 654ec50bb9e35308f4734140bea96424d11b23c3[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sun Mar 6 10:55:30 2022 -0300

    feat(infrastructure/): New app-of-apps Application

[33mcommit dd8f837cb6eb6ae9daa28e38076479142b791457[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sun Mar 6 10:30:23 2022 -0300

    feat(infrastructure/): Add Global Helm Parameters to ArgoCD Applications

[33mcommit a32ff94e88a92004d69af6ce7342b2451ef65fa5[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sun Mar 6 09:55:49 2022 -0300

    feat(kustomize/example/helm-example): Add a Helm Chart

[33mcommit d41609a60bed53b37c2bac4f70517e5aae7b7eec[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sun Mar 6 09:36:42 2022 -0300

    bump: version 0.1.0 → 0.2.0

[33mcommit 0269c59d532f2bc1559db4687c630dad42b8b33e[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sun Mar 6 09:21:01 2022 -0300

    feat(kustomize/): Add a kustomize directory

[33mcommit bb02743c2f532e5f728bbf56719d172780accdd2[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 5 19:09:02 2022 -0300

    feat(infrastructure/applications/values.yaml): Add argocd-config Helm Chart

[33mcommit 91ab5e79209603766db26abad8c89ff09c90ce25[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 5 18:27:25 2022 -0300

    feat(infrastructure/): Add new metrics-server Helm Chart

[33mcommit 140e77005b89c870e44948de55006e0651346ec3[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 5 18:08:14 2022 -0300

    feat(infrastructure/charts/): Add a ingress-nginx Helm Chart

[33mcommit 68d2cf0a976ee8abaff1fa03f1dcd43fc57ee1b6[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 5 17:57:16 2022 -0300

    feat(infrastructure/): Create crossplane-base and crossplane-providers Helm Charts

[33mcommit f04be25cf374a0b93417eb63d2239d5ee75349b3[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 5 14:29:16 2022 -0300

    feat(infrastructure/applications/values.yaml): Adding crossplane Helm Chart to the Cluster

[33mcommit b1f4e87f9ba2000b7992046a66c889ba2b79e8b7[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 5 14:28:30 2022 -0300

    feat(infrastructure/charts/crossplane/): Update Helm Chart with Crossplane Resources

[33mcommit b94fb7779f519f6bcc087cab6b2ee90ae14a2165[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 5 14:22:58 2022 -0300

    feature(infrastructure/charts/crossplane/): Create a new crossplane Helm Chart

[33mcommit b94bcbf7b1a72467b7cc576652001064386ea68b[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 5 14:12:02 2022 -0300

    feature(infrastructure/): Add new crossplane-install Helm Chart

[33mcommit 52ae0a3950ca28e6914c9aa178b97b4d5742a991[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 5 14:02:07 2022 -0300

    feat(infrastructure/argocd-project.yaml): Add namespaceResourceWhitelist and clusterResourceWhitelist

[33mcommit 7547cdfbce68d5bcc0984396578ecca24d43eb1a[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 5 13:55:56 2022 -0300

    feat(infrastructure/charts/external-secrets/): Add new external-secrets Helm Chart

[33mcommit 5c0f280da264d9d438f62b200642e1d76433f2d5[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 5 13:47:39 2022 -0300

    feat(infrastructure/): Create infra ArgoCd Project

[33mcommit 9cc748b0dd4de51601fa1c75619a1000063b053a[m[33m ([m[1;33mtag: 0.1.0[m[33m)[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 5 13:37:28 2022 -0300

    bump: version 0.0.1 → 0.1.0

[33mcommit 07dadd1e52eb7c6958121b52cc30ae44df896d60[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 5 13:37:21 2022 -0300

    feat(root): Init Conventional Commits

[33mcommit 216ccfe319a74726607b4a0e9274cb9565252c2c[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 5 13:36:38 2022 -0300

    refactor(infrastructure/argocd-application.yaml): move path parameter up

[33mcommit ac8451275c20c5240df178ec1a5be1d946aa046c[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 5 13:06:18 2022 -0300

    feat(infrastructure/applications/templates/application.yaml): ignore differences for CRDs and ValidatingWebhookConfiguration

[33mcommit 0cef2c44a7048e55f1f7fa2594469f1ad75dc06f[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 5 13:03:43 2022 -0300

    feat(infrastructure/charts/): Add istiod

[33mcommit 7c7bc5748a60e8daf3d1c6bfcd4c6c95cee23086[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 5 12:57:07 2022 -0300

    feat(infrastructure/): New namespaces Application

[33mcommit 3049072fa79594f91f1c4e9cfed79a47518bd3d0[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 5 12:55:48 2022 -0300

    fix(infrastructure/): Use namespace from Application

[33mcommit 3513119b2ea40cfa7a0b60536a4a579810ec7458[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 5 12:03:28 2022 -0300

    wip

[33mcommit 8669bc3b8dcd9fe0423bec4171acdae413b3ff60[m
Author: Silvio Silva <silvios.silva-ext3@ab-inbev.com>
Date:   Sat Mar 5 02:15:15 2022 -0300

    add new charts

[33mcommit 0a34251774970c7892ec43ad02843093a50e7248[m
Author: Silvio Silva <smsilva@gmail.com>
Date:   Sun Feb 27 14:12:08 2022 -0300

    Initial commit
