package com.kh.mybatis.member.Service;

import com.kh.mybatis.member.model.vo.Member;

public interface MemberService {
	public abstract Member loginMember(Member m);
	int insertMember(Member m);
}