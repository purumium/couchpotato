package com.kosa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.kosa.service.CalendarService;

@Controller
public class CalendarController {

	@Autowired
	private CalendarService calendarService;

	@GetMapping("/calendar")
	public String viewCalendar() {

		return "calendar";  // calendar.jsp로 이동
	}
}