package com.thoughtworks.model;

/**
 * 城镇类
 * 实现了equals方法
 * 实现了hashCode方法
 */
public class TWTown {
	private String name;

	public TWTown(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}

	@Override
	public String toString() {
		return name;
	}

	@Override
	public boolean equals(Object object) {
		if (this == object) {
			return true;
		} else if (object == null || getClass() != object.getClass()) {
			return false;
		} 
		TWTown town = (TWTown)object;
		return name != null ? name.equals(town.name) : town.name == null;
	}

	@Override
	public int hashCode() {
		return name != null ? name.hashCode() : 0;
	}

}