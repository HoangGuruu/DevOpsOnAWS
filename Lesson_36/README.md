![Alt text](../Banner.png)
# Bài 36 Triển khai một cụm Kubernetes EKS 

## Cài đặt AWS CLI + eksctl + Cấu hình AWS Configure

## Tạo cụm EKS & Nhóm Node

## Bước 00: Giới thiệu
- Hiểu về các thành phần cốt lõi của EKS
  - Control Plane
  - Worker Nodes & Nhóm Node
  - Fargate Profiles
  - VPC
- Tạo cụm EKS
- Liên kết cụm EKS với IAM OIDC Provider
- Tạo nhóm Node cho EKS
- Kiểm tra cụm, nhóm Node, EC2 Instances, IAM Policies và nhóm Node

## Cập nhật Access Key 

```sh
export AWS_ACCESS_KEY_ID=YOUR_ACCESS_KEY
export AWS_SECRET_ACCESS_KEY=YOUR_SECRET_KEY
export AWS_REGION=ap-southeast-1
```

## Bước 01: Tạo cụm EKS bằng eksctl
- Quá trình tạo Control Plane của cụm sẽ mất khoảng 15-20 phút.
```
# Tạo cụm
eksctl create cluster --name=eksdemo1 \
                      --region=ap-southeast-1 \
                      --zones=ap-southeast-1a,ap-southeast-1b \
                      --without-nodegroup 

eksctl create cluster --name=eksdemo3 \
                      --region=ap-southeast-1 \
                      --zones=ap-southeast-1a,ap-southeast-1b \
                      --without-nodegroup \
                      --version=1.32

# Lấy danh sách cụm
eksctl get cluster                  
```

## Bước 02: Tạo & Liên kết IAM OIDC Provider cho cụm EKS
- Để sử dụng IAM roles cho tài khoản dịch vụ Kubernetes trên cụm EKS, chúng ta cần tạo và liên kết OIDC identity provider.
- Sử dụng lệnh `eksctl` sau:
```                   
# Mẫu lệnh
eksctl utils associate-iam-oidc-provider \
    --region region-code \
    --cluster <cluster-name> \
    --approve

# Thay thế bằng region & tên cụm
eksctl utils associate-iam-oidc-provider \
    --region ap-southeast-1 \
    --cluster eksdemo2 \
    --approve
```

## Bước 03: Tạo Keypair EC2
- Tạo một EC2 Keypair mới có tên `Instance_Key_DevOps_On_AWS`
- Sử dụng keypair này khi tạo nhóm Node của EKS.
- Keypair này sẽ giúp chúng ta đăng nhập vào Worker Nodes của EKS thông qua Terminal.

## Bước 04: Tạo nhóm Node với các Add-Ons bổ sung trong Public Subnets
- Các add-ons này sẽ tự động tạo IAM policies cho chúng ta trong vai trò nhóm Node.
```
# Tạo nhóm Node Public   
eksctl create nodegroup --cluster=eksdemo1 \
                        --region=ap-southeast-1 \
                        --name=eksdemo1-ng-public1 \
                        --node-type=t3.medium \
                        --nodes=2 \
                        --nodes-min=2 \
                        --nodes-max=4 \
                        --node-volume-size=50 \
                        --ssh-access \
                        --ssh-public-key=Instance_Key_DevOps_On_AWS \
                        --managed \
                        --asg-access \
                        --external-dns-access \
                        --full-ecr-access \
                        --appmesh-access \
                        --alb-ingress-access 
```

## Bước 05: Kiểm tra cụm & Nodes

### Kiểm tra subnet nhóm Node để xác nhận EC2 Instances ở Public Subnet
- Vào **Services -> EKS -> eksdemo -> eksdemo1-ng1-public**
- Nhấp vào **Associated subnet** trong tab **Details**
- Chuyển sang tab **Route Table**
- Kiểm tra xem route internet có thông qua Internet Gateway (0.0.0.0/0 -> igw-xxxxxxxx)

### Kiểm tra cụm, nhóm Node trong EKS Management Console
- Vào **Services -> Elastic Kubernetes Service -> eksdemo**

### Liệt kê Worker Nodes
```
# Liệt kê cụm EKS
eksctl get cluster

# Liệt kê nhóm Node trong cụm
eksctl get nodegroup --cluster=<clusterName>

# Cập nhật kubeconfig
aws eks update-kubeconfig --region ap-southeast-1 --name eksdemo1

# Liệt kê Nodes trong cụm Kubernetes hiện tại
kubectl get nodes -o wide

# Xem kubeconfig hiện tại
kubectl config view --minify
```

### Kiểm tra IAM Role và danh sách Policies của Worker Node
- Vào **Services -> EC2 -> Worker Nodes**
- Nhấp vào **IAM Role liên kết với Worker Nodes**

### Kiểm tra Security Group liên kết với Worker Nodes
- Vào **Services -> EC2 -> Worker Nodes**
- Nhấp vào **Security Group** liên kết với EC2 Instance chứa `remote` trong tên.

### Kiểm tra CloudFormation Stacks
- Kiểm tra **Control Plane Stack & Events**
- Kiểm tra **NodeGroup Stack & Events**

### Đăng nhập vào Worker Node bằng Keypair kube-demo
```
# Dành cho MAC, Linux hoặc Windows 10
ssh -i Instance_Key_DevOps_On_AWS.pem ec2-user@<Public-IP-of-Worker-Node>
```

## Bước 06: Cập nhật Security Group của Worker Nodes để cho phép tất cả lưu lượng

## Tài liệu tham khảo
- https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html
- https://docs.aws.amazon.com/eks/latest/userguide/create-service-account-iam-policy-and-role.html


# Xóa cụm EKS & Nhóm Node

- Chú ý: Xóa hết các workload đã deploy để qáu trình xóa clsuter nhanh hơn, không bị treo
- Xóa hết các namespace đã dùng, cả workload của ns default

`kubectl delete ns {NameOfNamespace}`

## Bước 01: Xóa nhóm Node
```
# Liệt kê cụm EKS
eksctl get clusters

Xóa hết các namespace đã dùng, cả workload của ns default

# Lấy tên nhóm Node
eksctl get nodegroup --cluster=<clusterName>
eksctl get nodegroup --cluster=eksdemo1

# Xóa nhóm Node
eksctl delete nodegroup --cluster=<clusterName> --name=<nodegroupName>
eksctl delete nodegroup --cluster=eksdemo1 --name=eksdemo1-ng-public1
```

## Bước 02: Xóa cụm
```
# Xóa cụm
eksctl delete cluster <clusterName>
eksctl delete cluster eksdemo1
```
