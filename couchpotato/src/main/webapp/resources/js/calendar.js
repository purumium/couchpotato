$(document).ready(
		function() {
			$('#calendar').fullCalendar(
					{
						header : {
							left : 'prev,next today',
							center : 'title',
							right : 'month,agendaWeek,agendaDay'
						},
						events : [ {
							title : '인셉션',
							start : '2024-07-02',
							description : '영화 인셉션을 봤습니다.',
							imageUrl : '/path/to/inception.jpg' // 이미지 URL 추가
						} ],
						eventRender : function(event, element) {
							if (event.imageUrl) {
								element.find(".fc-content").append(
										"<img src='" + event.imageUrl
												+ "' width='100%'/>");
							}
						},
						dayClick : function(date, jsEvent, view) {
							var eventTitle = prompt('이 날짜에 볼 영화를 입력하세요:');
							if (eventTitle) {
								$('#calendar').fullCalendar('renderEvent', {
									title : eventTitle,
									start : date,
									allDay : true
								});
							}
						}
					});
		}
);