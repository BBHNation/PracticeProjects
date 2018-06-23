package com.thoughtworks.trains;

public class Town<T> {

    private T townIdentity;

    public Town(T townIdentity) {
        this.townIdentity = townIdentity;
    }

    public T getTownIdentity() {
       return townIdentity;
    }

    public void setTownIdentity(T townIdentity) {
       this.townIdentity = townIdentity;
    }

    @Override
    public boolean equals(Object obj) {
        return this.getTownIdentity().equals(((Town)obj).getTownIdentity());
    }

    @Override
    public int hashCode() {
        return townIdentity.hashCode();
    }
}
