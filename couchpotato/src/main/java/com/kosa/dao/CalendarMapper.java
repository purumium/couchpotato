package com.kosa.dao;

import org.apache.ibatis.annotations.Mapper;


@Mapper
public interface CalendarMapper {
	public Object getList();
}
