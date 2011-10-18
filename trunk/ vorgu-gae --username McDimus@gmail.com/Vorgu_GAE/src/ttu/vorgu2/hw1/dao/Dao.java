package ttu.vorgu2.hw1.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import ttu.vorgu2.hw1.model.Group;
import ttu.vorgu2.hw1.model.Person;

public enum Dao {
	INSTANCE;

	// BEGIN---------------- GROUP METHODS --------------------------------
	@SuppressWarnings("unchecked")
	public List<Group> getGroups() {
		EntityManager em = EMFService.get().createEntityManager();
		// Read the existing entries
		Query q = em.createQuery("select m from Group m");
		List<Group> groups = q.getResultList();
		return groups;
	}

	public void addGroup(String creator, String name, String description) {

		synchronized (this) {
			EntityManager em = EMFService.get().createEntityManager();

			Group group = new Group(creator, name, description, new Date());
			em.persist(group);
			em.close();
		}
	}

	public void deleteGroup(long id) {

		EntityManager em = EMFService.get().createEntityManager();
		try {
			Group group = em.find(Group.class, id);
			em.remove(group);
		} finally {
			em.close();
		}
	}

	// -END------------------ GROUP METHODS --------------------------------

	// -BEGIN---------------- PERSON METHODS -------------------------------
	@SuppressWarnings("unchecked")
	public List<Person> getPersons() {
		EntityManager em = EMFService.get().createEntityManager();
		// Read the existing entries
		Query q = em.createQuery("select m from Person m");
		List<Person> persons = q.getResultList();
		return persons;
	}

	public void addPerson(String username, String password, String firstname,
			String lastname, String phonenumber, String group,
			double longitude, double latitude) {

		synchronized (this) {
			EntityManager em = EMFService.get().createEntityManager();

			Person person = new Person(username, password, firstname, lastname,
					phonenumber, group, longitude, latitude, new Date());
			em.persist(person);
			em.close();
		}
	}

	public Person login(String username, String password) {
		EntityManager em = EMFService.get().createEntityManager();
		Query q = em
				.createQuery("select t from Person t where t.username = :username and t.password = :password");
		q.setParameter("username", username);
		q.setParameter("password", password);

		@SuppressWarnings("unchecked")
		List<Person> persons = q.getResultList();
		
		if (persons.size() == 1) {
			return persons.get(0);
		} else {
			return null;
		}

	}

	public void setGroupToPerson(String id, String groupname) {
		EntityManager em = EMFService.get().createEntityManager();
		try {
			Person person = em.find(Person.class, Long.parseLong(id));
			person.setGroup(groupname);
			em.persist(person);

		} finally {
			em.close();
		}
	}

	public void deletePerson(long id) {

		EntityManager em = EMFService.get().createEntityManager();
		try {
			Person person = em.find(Person.class, id);
			em.remove(person);

		} finally {
			em.close();
		}
	}
	// -END------------------ PERSON METHODS -------------------------------
}