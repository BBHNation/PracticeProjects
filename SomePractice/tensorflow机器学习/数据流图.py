import tensorflow as tf

g1 = tf.get_default_graph()
g2 = tf.Graph()

with g1.as_default():
    # constant
    a = tf.constant([5, 3], name="input_a")

    b = tf.reduce_prod(a, name="prod_b")
    c = tf.reduce_sum(a, name="sum_c")
    d = tf.add(c, b, name="output_d")



with g2.as_default():
    c = tf.constant(3, name="input_c")
    a = tf.constant(100, name="input_a")
    b = tf.constant(80, name="input_b")

    d = tf.multiply(a, c, name="mul_d")
    e = tf.add(d, b, name="add_e")
    f = tf.divide(e, 2, name="sub")

session = tf.Session(graph=g2)
print session.run(f)

