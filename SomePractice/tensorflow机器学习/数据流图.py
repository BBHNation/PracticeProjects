# coding:utf-8
import tensorflow as tf
import numpy as np

# 新建一个Graph
graph = tf.Graph()

with graph.as_default():
    with tf.name_scope("Variable"):
        # 记录数据流图运行次数
        global_step = tf.Variable(0, dtype=tf.int32, trainable=False, name="global_step")

        total_output = tf.Variable(0.0, dtype=tf.float32, trainable=False, name="total_output")

    with tf.name_scope("transformation"):
        with tf.name_scope("input"):
            a = tf.placeholder(tf.float32, shape=[None], name="input_placeholder_a")

        with tf.name_scope("intermediate_layer"):
            b = tf.reduce_prod(a, name="prod_b")
            c = tf.reduce_sum(a, name="sum_c")

        with tf.name_scope("output"):
            output = tf.add(b, c, name="output")

    with tf.name_scope("update"):
        # 自增total_output 并将其放在update_total中
        update_total = total_output.assign_add(output)
        increment_step = global_step.assign_add(1)

    with tf.name_scope("summary"):
        # 将increment_step 转换成tf.int32
        avg = tf.div(update_total, tf.cast(increment_step, tf.float32), name="average")

        # 为输入总结节点创建数据
        tf.summary.scalar("output", output)
        tf.summary.scalar("sum of outputs over time", update_total)
        tf.summary.scalar("average of outputs over time", avg)

    with tf.name_scope("globale_ops"):
        init = tf.global_variables_initializer()
        merged_summaried = tf.summary.merge_all()

    # 构建数据流图之后，开始运行
    sess = tf.Session()
    writer = tf.summary.FileWriter('./improved_graph', graph)
    sess.run(init)


    def run_graph(input_tensor):
        feed_dic = {a: input_tensor}
        _, step, summary = sess.run([output, increment_step, merged_summaried], feed_dict=feed_dic)
        writer.add_summary(summary, global_step=step)


    run_graph([2, 8])
    run_graph([3, 1, 2, 8])

    writer.flush()
    writer.close()
    sess.close()







