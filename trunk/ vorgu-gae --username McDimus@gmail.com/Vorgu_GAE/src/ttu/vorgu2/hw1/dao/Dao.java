package ttu.vorgu2.hw1.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import ttu.vorgu2.hw1.SerializablePerson;
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

	public void addGroup(String creatorId, String creator, String name,
			String description) {

		synchronized (this) {
			EntityManager em = EMFService.get().createEntityManager();

			Group group = new Group(creator, name, description, new Date());
			em.persist(group);
			em.close();

		}
		setGroupToPerson(creatorId, name);
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

	public Person checkPerson(String username) {
		EntityManager em = EMFService.get().createEntityManager();
		Query q = em
				.createQuery("select t from Person t where t.username = :username");
		q.setParameter("username", username);

		@SuppressWarnings("unchecked")
		List<Person> persons = q.getResultList();

		if (persons.size() == 1) {
			return persons.get(0);
		} else {
			return null;
		}
	}

	public void updatePerson(String username, String password,
			String firstname, String lastname, String phonenumber,
			double latitude, double longitude) {
		EntityManager em = EMFService.get().createEntityManager();
		Query q = em.createQuery("update t set t.password=:password,"
				+ " t.firstname=:firstname, lastname=:lastname,"
				+ " t.phoneNumber=:phonenumber, latitude=:latitude,"
				+ " t.longitude=:longitude where t.username=:username");
		q.setParameter("username", username);
		q.setParameter("password", password);
		q.setParameter("firstname", firstname);
		q.setParameter("lastname", lastname);
		q.setParameter("phonenumber", phonenumber);
		q.setParameter("latitude", latitude);
		q.setParameter("longitude", longitude);
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

	public List<SerializablePerson> setCoordsToPerson(String id,
			double latitude, double longitude) {
		EntityManager em = EMFService.get().createEntityManager();
		Query q = em
				.createQuery("select t from Person t where t.username = :id");
		q.setParameter("id", id);

		Person person = em.find(Person.class, Long.parseLong(id));

		String groupname = person.getGroup();
		person.setLatitude(latitude);
		person.setLongitude(longitude);
		em.persist(person);

		Query q2 = em
				.createQuery("select t from Person t where t.group = :groupname");
		q2.setParameter("groupname", groupname);
		@SuppressWarnings("unchecked")
		List<Person> persons = q2.getResultList();
		List<SerializablePerson> serializablePersons = new ArrayList<SerializablePerson>();
		for (Person personFromList : persons) {
			SerializablePerson serializablePerson = new SerializablePerson(
					personFromList.getUsername(), personFromList.getPassword(),
					personFromList.getFirstname(), personFromList.getLastname(), personFromList.getPhonenumber(),
					personFromList.getGroup(), personFromList.getLongitude(), personFromList.getLatitude());
			serializablePersons.add(serializablePerson);
		}
		em.close();
		return serializablePersons;
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