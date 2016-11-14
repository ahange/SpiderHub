<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Project</title>
<link href="<%=request.getContextPath()%>/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/bootstrap-theme.min.css" />
<script src="<%=request.getContextPath()%>/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
		<nav>
			<ul class="nav nav-pills pull-right">
				<li role="presentation" class="active"><a href="../index.html">Home</a></li>
			</ul>
		</nav>
		<security:authorize access="authenticated">
			<h3 class="text-muted">
				Welcome,
				<security:authentication property="principal.username" />
			</h3>
		</security:authorize>
		<div class="jumbotron">
		<h1>Project Details</h1>
		<table class="table table-hover">
			<tr>
				<th>ID</th>
				<td>${project.id}</td>
			</tr>
			<tr>
				<th>TaskName</th>
				<td>${project.projectName}</td>
			</tr>
			<tr>
				<th>Description</th>
				<td>${project.projectDescription}</td>
			</tr>

		</table>

		<h1>Task Details</h1>
		<table class="table table-hover">
			<tr>
				<th>Task</th>
				<th>Task Status</th>
				<th>Operation</th>
			</tr>

			<c:forEach items="${tasks}" var="task">

				<tr>
					<td>${task.taskName}</td>
					<c:choose>
						<c:when test="${empty task.statusTasks.statusName}">
							<td>Incomplete</td>
						</c:when>
						<c:otherwise>
							<td>${task.statusTasks.statusName }</td>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${empty task.userTasks}">
							<td><a
								href="assignTask.html?tid=${task.id}&pid=${project.id}">Assign</a></td>
						</c:when>
						<c:otherwise>
							<td>Already Assigned</td>
						</c:otherwise>
					</c:choose>
				</tr>

			</c:forEach>
		</table>
		<a href="addUserInProject.html?id=${project.id}">Add User In
			Project</a> <br /> <a href="addTask.html?id=${project.id}">Add Task
			In Project</a>
	</div>
		<jsp:include page="/WEB-INF/jsp/footer.jsp" />
	</div>

</body>
</html>