<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>

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
	<h1>Assigned Tasks</h1>
	<table class="table table-hover">
		<tr>
			<th>Task</th>
			<th>Task Description</th>
			<th>Operation</th>
			<th>Assigned By</th>
		</tr>

		<c:forEach items="${task}" var="task">

			<tr>
				<td>${task.taskName}</td>
				<td>${task.taskDescription}</td>
				<td><c:if test="${task.statusTasks.id==1 }">
						<a href="doneTask.html?tid=${task.id}&pid=${project.id}"><img
							src="<%=request.getContextPath()%>/IMAGE/delete.png" /></a>
					</c:if> <c:if test="${task.statusTasks.id==2 }">
					Done
					</c:if></td>
				<td>${project.createdUser.userName}</td>
				<td><a href="viewTask.html?tid=${task.id}&pid=${project.id}">View</a></td>
				
			</tr>


		</c:forEach>
	</table>
</div>
