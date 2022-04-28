# outputs.tf

output "container_desired_count" {
  value = aws_ecs_service.main.desired_count
}

output "target_container" {
  value = "${element(aws_ecs_service.main.load_balancer[*].container_name,0)}"
}

output "target_port" {
  value = "${element(aws_ecs_service.main.load_balancer[*].container_port, 0)}"
}

output "task_cpu" {
  value = aws_ecs_task_definition.main.cpu
}

output "task_memory" {
  value = aws_ecs_task_definition.main.memory
}

output "task_revision" {
  value = aws_ecs_task_definition.main.revision
}

output "lb_public_dns" {
  value = aws_lb.main.lb_public_dns
}

