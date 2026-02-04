enum TaskService {

    private static let basePath = "tasks"

    static func getTasks() -> Endpoint<[TaskResponseDTO]> {
        Endpoint(
            path: basePath,
            method: .get
        )
    }

    static func createTask(
        _ request: TaskRequestDTO
    ) -> Endpoint<TaskResponseDTO> {
        Endpoint(
            path: basePath,
            method: .post,
            bodyParametersEncodable: request
        )
    }

    static func deleteTask(id: String) -> Endpoint<DeleteTaskResponse> {
        Endpoint(
            path: "\(basePath)/\(id)",
            method: .delete
        )
    }
}
