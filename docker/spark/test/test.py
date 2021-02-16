from pyspark.sql import SparkSession

class Log4j:
    def __init__(self, spark: SparkSession):
        conf = spark.sparkContext.getConf()
        app_id = conf.get("spark.app.id")
        app_name = conf.get("spark.app.name")
        log4j = spark._jvm.org.apache.log4j
        message_prefix = f"<{app_name} {app_id}>"
        self.logger = log4j.LogManager.getLogger(message_prefix)

    def error(self, message: str) -> None:
        self.logger.error(message)

    def warn(self, message: str) -> None:
        self.logger.warn(message)

    def info(self, message: str) -> None:
        self.logger.info(message)
def get_spark_session(app_name):
    spark = SparkSession.builder.appName(app_name) \
                                .enableHiveSupport()\
                                .getOrCreate()
    spark.sparkContext.setLogLevel("INFO")
    log = Log4j(spark)
    return spark, log

if __name__ == "__main__":
    spark, log = get_spark_session("test")
    print(spark.catalog.listDatabases())
    spark.sql("select * from iris_partitioned").show(100)